#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

GEN_DATA_SCALE=$1
EXPLAIN_ANALYZE=$2
E9=$3   
RANDOM_DISTRIBUTION=$4
TPCDS_VERSION=$5

if [[ "$GEN_DATA_SCALE" == "" || "$EXPLAIN_ANALYZE" == "" || "$E9" == "" || "$RANDOM_DISTRIBUTION" == "" || "$TPCDS_VERSION" == "" ]]; then
	echo "You must provide the scale as a parameter in terms of Gigabytes, true/false to run queries with EXPLAIN ANALYZE option, E9 true or false to use their version of TPC-DS, and true/false to use random distrbution."
	echo "Example: ./rollout.sh 100 false false false 1.4"
	echo "This will create 100 GB of data for this test, not run EXPLAIN ANALYZE, use standard TPC-DS, not use random distribution, and use version 1.4 of the TPC-DS benchmark."
	exit 1
fi

step=compile_tpcds
init_log $step
start_log
schema_name="tpcds"
table_name="compile"

check_version()
{
	if [ ! -d "$PWD/$TPCDS_VERSION" ]; then
		echo "TPC-DS version $TPCDS_VERSION not found!"
		exit 1
	fi
}

make_tpc()
{
	#compile the tools
	cd $PWD/$TPCDS_VERSION/tools
	rm -f *.o
	make
	cd ../..
}

copy_tpc()
{
	cp $PWD/$TPCDS_VERSION/tools/dsqgen ../*gen_data/
	cp $PWD/$TPCDS_VERSION/tools/dsqgen ../testing/
	cp $PWD/$TPCDS_VERSION/tools/tpcds.idx ../*gen_data/
	cp $PWD/$TPCDS_VERSION/tools/tpcds.idx ../testing/

	#copy the compiled dsdgen program to the segment hosts
	for i in $(cat $PWD/../segment_hosts.txt); do
		echo "copy tpcds binaries to $i:$ADMIN_HOME"
		scp $TPCDS_VERSION/tools/dsdgen $TPCDS_VERSION/tools/tpcds.idx $i:$ADMIN_HOME/
	done
}

copy_queries()
{
	rm -rf $PWD/../*_gen_data/query_templates
	rm -rf $PWD/../testing/query_templates
	cp -R $TPCDS_VERSION/query_templates $PWD/../*_gen_data/
	cp -R $TPCDS_VERSION/query_templates $PWD/../testing/
}

check_version
make_tpc
create_hosts_file
copy_tpc
copy_queries
log

end_step $step
