#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

GEN_DATA_SCALE=$1

if [ "$GEN_DATA_SCALE" == "" ]; then
	echo "You must provide the scale as a parameter in terms of Gigabytes."
	echo "Example: ./rollout.sh 100"
	echo "This will create 100 GB of data for this test."
	exit 1
fi

get_count_generate_data()
{
	count="0"
	for i in $(cat $PWD/../segment_hosts.txt); do
		next_count=$(ssh -o ConnectTimeout=0 -n -f $i "bash -c 'ps -ef | grep generate_data.sh | grep -v grep | wc -l'" 2>&1 || true)
		check="^[0-9]+$"
		if ! [[ $next_count =~ $check ]] ; then
			next_count="1"
		fi
		count=$(($count + $next_count))
	done
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
	if [[ "$VERSION" == *"gpdb"* ]]; then
		PARALLEL=$(gpstate | grep "Total primary segments" | awk -F '=' '{print $2}')
		if [ "$PARALLEL" == "" ]; then
			echo "ERROR: Unable to determine how many primary segments are in the cluster using gpstate."
			exit 1
		fi
		echo "parallel: $PARALLEL"
		if [ "$VERSION" == "gpdb_6" ]; then
			for i in $(psql -v ON_ERROR_STOP=1 -q -A -t -c "select row_number() over(), g.hostname, g.datadir from gp_segment_configuration g where g.content >= 0 and g.role = 'p' order by 1, 2, 3"); do
				CHILD=$(echo $i | awk -F '|' '{print $1}')
				EXT_HOST=$(echo $i | awk -F '|' '{print $2}')
				GEN_DATA_PATH=$(echo $i | awk -F '|' '{print $3}')
				GEN_DATA_PATH="$GEN_DATA_PATH""/dsbenchmark"
				echo "ssh -n -f $EXT_HOST \"bash -c 'cd ~/; ./generate_data.sh $GEN_DATA_SCALE $CHILD $PARALLEL $GEN_DATA_PATH > generate_data.$CHILD.log 2>&1 < generate_data.$CHILD.log &'\""
				ssh -n -f $EXT_HOST "bash -c 'cd ~/; ./generate_data.sh $GEN_DATA_SCALE $CHILD $PARALLEL $GEN_DATA_PATH > generate_data.$CHILD.log 2>&1 < generate_data.$CHILD.log &'"
			done
		else
			for i in $(psql -v ON_ERROR_STOP=1 -q -A -t -c "select row_number() over(), g.hostname, p.fselocation as path from gp_segment_configuration g join pg_filespace_entry p on g.dbid = p.fsedbid join pg_tablespace t on t.spcfsoid = p.fsefsoid where g.content >= 0 and g.role = 'p' and t.spcname = 'pg_default' order by 1, 2, 3"); do
				CHILD=$(echo $i | awk -F '|' '{print $1}')
				EXT_HOST=$(echo $i | awk -F '|' '{print $2}')
				GEN_DATA_PATH=$(echo $i | awk -F '|' '{print $3}')
				GEN_DATA_PATH="$GEN_DATA_PATH""/dsbenchmark"
				echo "ssh -n -f $EXT_HOST \"bash -c 'cd ~/; ./generate_data.sh $GEN_DATA_SCALE $CHILD $PARALLEL $GEN_DATA_PATH > generate_data.$CHILD.log 2>&1 < generate_data.$CHILD.log &'\""
				ssh -n -f $EXT_HOST "bash -c 'cd ~/; ./generate_data.sh $GEN_DATA_SCALE $CHILD $PARALLEL $GEN_DATA_PATH > generate_data.$CHILD.log 2>&1 < generate_data.$CHILD.log &'"
			done
		fi
	else
		#PostgreSQL
		#use the number of cores to determine the level of parallelism
		PARALLEL=$(lscpu --parse=cpu | grep -v "#" | wc -l)
		echo "parallel: $PARALLEL"
		if [ "$PGDATA" == "" ]; then
			echo "ERROR: Unable to determine PGDATA environment variable.  Be sure to have this set for the admin user."
			exit 1
		fi
		CHILD="0"
		EXT_HOST=$HOSTNAME
		for x in $(seq 1 $PARALLEL); do
			CHILD=$(($CHILD + 1))
			GEN_DATA_PATH="$PGDATA""/dsbenchmark_""$CHILD"
			echo "ssh -n -f $EXT_HOST \"bash -c 'cd ~/; ./generate_data.sh $GEN_DATA_SCALE $CHILD $PARALLEL $GEN_DATA_PATH > generate_data.$CHILD.log 2>&1 < generate_data.$CHILD.log &'\""
			ssh -n -f $EXT_HOST "bash -c 'cd ~/; ./generate_data.sh $GEN_DATA_SCALE $CHILD $PARALLEL $GEN_DATA_PATH > generate_data.$CHILD.log 2>&1 < generate_data.$CHILD.log &'"
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
