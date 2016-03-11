#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

GEN_DATA_SCALE=$1
EXPLAIN_ANALYZE=$2
SQL_VERSION=$3   
RANDOM_DISTRIBUTION=$4
HAWQ2_NVSEG_PERSEG=$5

if [[ "$GEN_DATA_SCALE" == "" || "$EXPLAIN_ANALYZE" == "" || "$SQL_VERSION" == "" || "$RANDOM_DISTRIBUTION" == "" || "$HAWQ2_NVSEG_PERSEG" == "" ]]; then
	echo "You must provide the scale as a parameter in terms of Gigabytes, true/false to run queries with EXPLAIN ANALYZE option, the SQL_VERSION, and true/false to use random distrbution."
	echo "Example: ./rollout.sh 100 false tpcds false 8"
	echo "This will create 100 GB of data for this test, not run EXPLAIN ANALYZE, use standard TPC-DS, and not use random distribution."
	exit 1
fi

step=compile_tpcds
init_log $step
start_log
schema_name="tpcds"
table_name="compile"

make_tpc()
{
	#compile the tools
	cd $PWD/tools
	rm -f *.o
	make
	cd ..
}

copy_tpc()
{
	cp $PWD/tools/dsqgen ../*gen_data/
	cp $PWD/tools/dsqgen ../testing/
	cp $PWD/tools/tpcds.idx ../*gen_data/
	cp $PWD/tools/tpcds.idx ../testing/

	#copy the compiled dsdgen program to the segment hosts
	for i in $(cat $PWD/../segment_hosts.txt); do
		echo "copy tpcds binaries to $i:$ADMIN_HOME"
		scp tools/dsdgen tools/tpcds.idx $i:$ADMIN_HOME/
	done
}

copy_queries()
{
	rm -rf $PWD/../*_gen_data/query_templates
	rm -rf $PWD/../testing/query_templates
	cp -R query_templates $PWD/../*_gen_data/
	cp -R query_templates $PWD/../testing/
}

make_tpc
create_hosts_file
copy_tpc
copy_queries
log

end_step $step
