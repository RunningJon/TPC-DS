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
	cd $PWD/tools

	#copy the compiled dsdgen program to the segment hosts
	for i in $(psql -t -A -c "SELECT DISTINCT hostname FROM gp_segment_configuration ORDER BY hostname"); do
		echo "scp dsdgen dsqgen tpcds.idx $ADMIN_USER@$i:$ADMIN_HOME/"
		scp dsdgen dsqgen tpcds.idx $ADMIN_USER@$i:$ADMIN_HOME/
	done

	cd ..

	cp $PWD/tools/dsdgen $PWD/../
	cp $PWD/tools/dsqgen $PWD/../
	cp $PWD/tools/tpcds.idx $PWD/../
}

copy_queries()
{
	rm -rf $PWD/../*_gen_data/query_templates
	cp -R query_templates $PWD/../*_gen_data/
}

make_tpc
copy_tpc
copy_queries
log

end_step $step
