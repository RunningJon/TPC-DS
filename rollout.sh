#!/bin/bash

set -e
PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/functions.sh
source_bashrc

GEN_DATA_SCALE=$1
EXPLAIN_ANALYZE=$2
SQL_VERSION=$3
RANDOM_DISTRIBUTION=$4
RUN_COMPILE_TPCDS=$5
RUN_GEN_DATA=$6
RUN_INIT=$7
RUN_DDL=$8
RUN_LOAD=$9
RUN_SQL=$10

if [[ "$GEN_DATA_SCALE" == "" || "$EXPLAIN_ANALYZE" == "" || "$SQL_VERSION" == "" || "$RANDOM_DISTRIBUTION" == "" || "$RUN_COMPILE_TPCDS" == "" || "$RUN_GEN_DATA" == "" || "$RUN_INIT" == "" || "$RUN_DDL" == "" || "$RUN_LOAD" == "" || "$RUN_SQL" == "" ]]; then
	echo "You must provide the scale as a parameter in terms of Gigabytes, true/false to run queries with EXPLAIN ANALYZE option, the SQL_VERSION, and true/false to use random distrbution."
	echo "Example: ./rollout.sh 100 false tpcds false true true true true true true"
	echo "This will create 100 GB of data for this test, not run EXPLAIN ANALYZE, use standard TPC-DS, and not use random distribution."
	echo "The last six run options indicate if you want to force the running of those steps even if the step has already completed."
	exit 1
fi

QUIET=$5

create_directories()
{
	if [ ! -d $LOCAL_PWD/log ]; then
		echo "Creating log directory"
		mkdir $LOCAL_PWD/log
	fi
}

create_directories
echo "############################################################################"
echo "TPC-DS Script for Pivotal Greenplum Database and Pivotal HAWQ."
echo "############################################################################"
echo ""
echo "############################################################################"
echo "GEN_DATA_SCALE: $GEN_DATA_SCALE"
echo "EXPLAIN_ANALYZE: $EXPLAIN_ANALYZE"
echo "SQL_VERSION: $SQL_VERSION"
echo "RANDOM_DISTRIBUTION: $RANDOM_DISTRIBUTION"
echo "RUN_COMPILE_TPCDS: $RUN_COMPILE_TPCDS"
echo "RUN_GEN_DATA: $RUN_GEN_DATA"
echo "RUN_INIT: $RUN_INIT"
echo "RUN_DDL: $RUN_DDL"
echo "RUN_LOAD: $RUN_LOAD"
echo "RUN_SQL: $RUN_SQL"
echo "############################################################################"
echo ""
if [ "$RUN_COMPILE_TPCDS" == "true" ]; then
	rm -f $PWD/log/end_compile_tpcds.log
fi
if [ "$RUN_GEN_DATA" == "true" ]; then
	rm -f $PWD/log/end_gen_data.log
fi
if [ "$RUN_INIT" == "true" ]; then
	rm -f $PWD/log/end_init.log
fi
if [ "$RUN_DDL" == "true" ]; then
	rm -f $PWD/log/end_ddl.log
fi
if [ "$RUN_LOAD" == "true" ]; then
	rm -f $PWD/log/end_load.log
fi
if [ "$RUN_SQL" == "true" ]; then
	rm -f $PWD/log/end_sql.log
	rm -f $PWD/log/end_testing_*.log
fi

for i in $(ls -d $PWD/0*); do
	echo "$i/rollout.sh"
	$i/rollout.sh $GEN_DATA_SCALE $EXPLAIN_ANALYZE $SQL_VERSION $RANDOM_DISTRIBUTION 
done
