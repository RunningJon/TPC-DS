#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

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
	cp $PWD/tools/dsqgen ../*_gen_data/
	cp $PWD/tools/dsqgen ../*_multi_user/
	cp $PWD/tools/tpcds.idx ../*_gen_data/
	cp $PWD/tools/tpcds.idx ../*_multi_user/

	#copy the compiled dsdgen program to the segment hosts
	for i in $(cat $PWD/../segment_hosts.txt); do
		echo "copy tpcds binaries to $i:$ADMIN_HOME"
		scp tools/dsdgen tools/tpcds.idx $i:$ADMIN_HOME/
	done
}

copy_queries()
{
	rm -rf $PWD/../*_gen_data/query_templates
	rm -rf $PWD/../*_multi_user/query_templates
	cp -R query_templates $PWD/../*_gen_data/
	cp -R query_templates $PWD/../*_multi_user/
}

make_tpc
create_hosts_file
copy_tpc
copy_queries
log

end_step $step
