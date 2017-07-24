#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

step=load
init_log $step

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

ADMIN_HOME=$(eval echo ~$ADMIN_USER)

copy_script()
{
	echo "copy the start and stop scripts to the hosts in the cluster"
	for i in $(cat $PWD/../segment_hosts.txt); do
		echo "scp start_gpfdist.sh stop_gpfdist.sh $ADMIN_USER@$i:$ADMIN_HOME/"
		scp $PWD/start_gpfdist.sh $PWD/stop_gpfdist.sh $ADMIN_USER@$i:$ADMIN_HOME/
	done
}

stop_gpfdist()
{
	echo "stop gpfdist on all ports"
	for i in $(cat $PWD/../segment_hosts.txt); do
		ssh -n -f $i "bash -c 'cd ~/; ./stop_gpfdist.sh'"
	done
}

start_gpfdist()
{
	stop_gpfdist
	sleep 1

	get_version
	if [[ "$VERSION" == "gpdb_4_2" || "$VERSION" == "gpdb_4_3" || "$VERSION" == "gpdb_5" || "$VERSION" == "hawq_1" ]]; then
		for i in $(psql -A -t -c "select rank() over (partition by hostname order by path), trim(hostname), trim(path) from data_dir order by hostname"); do
			CHILD=$(echo $i | awk -F '|' '{print $1}')
			EXT_HOST=$(echo $i | awk -F '|' '{print $2}')
			GEN_DATA_PATH=$(echo $i | awk -F '|' '{print $3}')
			GEN_DATA_PATH=$GEN_DATA_PATH/pivotalguru
			PORT=$(($GPFDIST_PORT + $CHILD))
			echo "executing on $EXT_HOST ./start_gpfdist.sh $PORT $GEN_DATA_PATH"
			ssh -n -f $EXT_HOST "bash -c 'cd ~/; ./start_gpfdist.sh $PORT $GEN_DATA_PATH'"
			sleep 1
		done
	else
		#HAWQ 2
		get_nvseg_perseg
		for i in $(psql -A -t -c "SELECT trim(path) FROM public.data_dir"); do
			SEG_DATA_PATH=$i
		done

		for i in $(cat $PWD/../segment_hosts.txt); do
			EXT_HOST=$i
			for x in $(seq 1 $nvseg_perseg); do
				GEN_DATA_PATH="$SEG_DATA_PATH""/pivotalguru_""$x"
				PORT=$(($GPFDIST_PORT + $x))
				echo "executing on $EXT_HOST ./start_gpfdist.sh $PORT $GEN_DATA_PATH"
				ssh -n -f $EXT_HOST "bash -c 'cd ~/; ./start_gpfdist.sh $PORT $GEN_DATA_PATH'"
				sleep 1
			done
		done
	fi
}

copy_script
start_gpfdist

for i in $(ls $PWD/*.sql); do
	start_log

	id=`echo $i | awk -F '.' '{print $1}'`
	schema_name=`echo $i | awk -F '.' '{print $2}'`
	table_name=`echo $i | awk -F '.' '{print $3}'`

	echo "psql -v ON_ERROR_STOP=ON -f $i | grep INSERT | awk -F ' ' '{print \$3}'"
	tuples=$(psql -v ON_ERROR_STOP=ON -f $i | grep INSERT | awk -F ' ' '{print $3}'; exit ${PIPESTATUS[0]})

	log $tuples
done

stop_gpfdist

#Analyze schema using analyzedb

max_id=$(ls $PWD/*.sql | tail -1)
i=$(basename $max_id | awk -F '.' '{print $1}')

dbname="$PGDATABASE"
if [ "$dbname" == "" ]; then
	dbname="$ADMIN_USER"
fi

if [ "$PGPORT" == "" ]; then
	export PGPORT=5432
fi

start_log

schema_name="tpcds"
table_name="tpcds"

analyzedb -d $dbname -s tpcds --full -a

tuples="0"
log $tuples

end_step $step
