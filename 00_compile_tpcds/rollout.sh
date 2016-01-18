#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

GEN_DATA_SCALE=$1
EXPLAIN_ANALYZE=$2
E9=$3   
RANDOM_DISTRIBUTION=$4
VERSION=$5

if [[ "$GEN_DATA_SCALE" == "" || "$EXPLAIN_ANALYZE" == "" || "$E9" == "" || "$RANDOM_DISTRIBUTION" == "" || "$VERSION" == "" ]]; then
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
	if [ ! -d "$PWD/$VERSION" ]; then
		echo "TPC-DS version $VERSION not found!"
		exit 1
	fi
}

make_tpc()
{
	#compile the tools
	cd $PWD/$VERSION/tools
	rm -f *.o
	make
	cd ../..
}

copy_tpc()
{
	cp $PWD/$VERSION/tools/dsqgen ../*gen_data/
	cp $PWD/$VERSION/tools/dsqgen ../testing/
	cp $PWD/$VERSION/tools/tpcds.idx ../*gen_data/
	cp $PWD/$VERSION/tools/tpcds.idx ../testing/

	#copy the compiled dsdgen program to the segment hosts
	for i in $(cat $PWD/../segment_hosts.txt); do
		echo "copy tpcds binaries to $i:$ADMIN_HOME"
		scp $VERSION/tools/dsdgen $VERSION/tools/tpcds.idx $i:$ADMIN_HOME/
	done
}

copy_queries()
{
	rm -rf $PWD/../*_gen_data/query_templates
	rm -rf $PWD/../testing/query_templates
	cp -R $VERSION/query_templates $PWD/../*_gen_data/
	cp -R $VERSION/query_templates $PWD/../testing/
}

check_version
make_tpc
create_hosts_file
copy_tpc
copy_queries
log

end_step $step
