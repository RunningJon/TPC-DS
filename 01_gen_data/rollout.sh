#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

GEN_DATA_SCALE=$1
EXPLAIN_ANALYZE=$2
SQL_VERSION=$3
RANDOM_DISTRIBUTION=$4
MULTI_USER_COUNT=$5
SINGLE_USER_ITERATIONS=$6

if [[ "$GEN_DATA_SCALE" == "" || "$EXPLAIN_ANALYZE" == "" || "$SQL_VERSION" == "" || "$RANDOM_DISTRIBUTION" == "" || "$MULTI_USER_COUNT" == "" || "$SINGLE_USER_ITERATIONS" == "" ]]; then
	echo "You must provide the scale as a parameter in terms of Gigabytes, true/false to run queries with EXPLAIN ANALYZE option, the SQL_VERSION, and true/false to use random distrbution."
	echo "Example: ./rollout.sh 100 false tpcds false 5 1"
	echo "This will create 100 GB of data for this test, not run EXPLAIN ANALYZE, use standard TPC-DS, not use random distribution and use 5 sessions for the multi-user test."
	exit 1
fi

get_count_generate_data()
{
	count="0"
	for i in $(cat $PWD/../segment_hosts.txt); do
		next_count=$(ssh -o ConnectTimeout=0 -n -t $i "bash -c 'ps -ef | grep generate_data.sh | grep -v grep | wc -l'" 2>&1 || true)
		check="^[0-9]+$"
		if ! [[ $next_count =~ $check ]] ; then
			next_count="1"
		fi
		count=$(($count + $next_count))
	done
}

create_table_data_dir()
{
	# this table shows the path to each segment's data directory
	get_version
	if [[ "$VERSION" == "gpdb_4_2" || "$VERSION" == "gpdb_4_3" || "$VERSION" == "gpdb_5" || "$VERSION" == "hawq_1" ]]; then
		SEGMENTS="all"
	else
		#must be HAWQ 2
		#HAWQ 2 has 1 segment directory per host with the same PGDATA value
		#ON ALL isn't supported either so use just 1 segment and use the segment_hosts.txt file
		SEGMENTS="1"
		#SEGMENTS=$(hawq state | grep "Total segments count" | awk -F '=' '{print $2}')
	fi
	psql -a -v ON_ERROR_STOP=1 -v SEGMENTS="$SEGMENTS" -t $PWD/data_dir.sql
}

kill_orphaned_data_gen()
{
	for i in $(cat $PWD/../segment_hosts.txt); do
		echo "$i:kill any orphaned processes"
		for k in $(ssh $i "ps -ef | grep dsdgen | grep -v grep" | awk -F ' ' '{print $2}'); do
			echo killing $k
			ssh $i "kill $k"
		done
	done
}

copy_generate_data()
{
	#copy generate_data.sh to ~/
	for i in $(cat $PWD/../segment_hosts.txt); do
		echo "copy generate_data.sh to $i:$ADMIN_HOME"
		scp $PWD/generate_data.sh $i:$ADMIN_HOME/
	done
}

gen_data()
{
	get_version
	if [[ "$VERSION" == "gpdb_4_2" || "$VERSION" == "gpdb_4_3" || "$VERSION" == "gpdb_5" || "$VERSION" == "hawq_1" ]]; then
		PARALLEL=$(gpstate | grep "Total primary segments" | awk -F '=' '{print $2}')
		if [ "$PARALLEL" == "" ]; then
			echo "ERROR: Unable to determine how many primary segments are in the cluster using gpstate."
			exit 1
		fi
		echo "parallel: $PARALLEL"
		for i in $(psql -A -t -c "SELECT row_number() over(), trim(hostname), trim(path) FROM public.data_dir"); do
			CHILD=$(echo $i | awk -F '|' '{print $1}')
			EXT_HOST=$(echo $i | awk -F '|' '{print $2}')
			GEN_DATA_PATH=$(echo $i | awk -F '|' '{print $3}')
			GEN_DATA_PATH="$GEN_DATA_PATH""/pivotalguru"
			echo "ssh -n -t $EXT_HOST \"bash -c 'cd ~/; ./generate_data.sh $GEN_DATA_SCALE $CHILD $PARALLEL $GEN_DATA_PATH > generate_data.$CHILD.log 2>&1 < generate_data.$CHILD.log &'\""
			ssh -n -t $EXT_HOST "bash -c 'cd ~/; ./generate_data.sh $GEN_DATA_SCALE $CHILD $PARALLEL $GEN_DATA_PATH > generate_data.$CHILD.log 2>&1 < generate_data.$CHILD.log &'"
		done
	else
		#HAWQ 2
		get_nvseg_perseg
		PARALLEL=$(hawq state | grep "Total segments count" | awk -F '=' '{print $2}')
		PARALLEL=$(($PARALLEL * $nvseg_perseg))
		echo "parallel: $PARALLEL"

		#get the PGDATA value which is the same on all hosts for HAWQ 2
		for i in $(psql -A -t -c "SELECT trim(path) FROM public.data_dir"); do
			SEG_DATA_PATH="$i"
		done

		CHILD="0"
		for i in $(cat $PWD/../segment_hosts.txt); do
			EXT_HOST=$i
			for x in $(seq 1 $nvseg_perseg); do
				GEN_DATA_PATH="$SEG_DATA_PATH""/pivotalguru_""$x"
				CHILD=$(($CHILD + 1))
				echo "ssh -n -t $EXT_HOST \"bash -c 'cd ~/; ./generate_data.sh $GEN_DATA_SCALE $CHILD $PARALLEL $GEN_DATA_PATH > generate_data.$CHILD.log 2>&1 < generate_data.$CHILD.log &'\""
				ssh -n -t $EXT_HOST "bash -c 'cd ~/; ./generate_data.sh $GEN_DATA_SCALE $CHILD $PARALLEL $GEN_DATA_PATH > generate_data.$CHILD.log 2>&1 < generate_data.$CHILD.log &'"
			done
		done
	fi

}

step=gen_data
init_log $step
start_log
schema_name="tpcds"
table_name="gen_data"

kill_orphaned_data_gen
copy_generate_data
create_table_data_dir
gen_data

echo ""
get_count_generate_data
echo "Now generating data.  This make take a while."
echo -ne "Generating data"
while [ "$count" -gt "0" ]; do
	echo -ne "."
	sleep 5
	get_count_generate_data
done

echo "Done generating data"
echo ""

echo "Generate queries based on scale"
cd $PWD
$PWD/generate_queries.sh $GEN_DATA_SCALE

log

end_step $step
