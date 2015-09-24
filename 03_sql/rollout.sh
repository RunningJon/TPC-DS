#!/bin/bash
set -e
source ../functions.sh
get_version

step=sql
init $step

for i in $(ls *.sql); do
	start_log


	
	id=`echo $i | awk -F '.' '{print $1}'`
	schema_name=`echo $i | awk -F '.' '{print $2}'`
	table_name=`echo $i | awk -F '.' '{print $3}'`
	optimizer=`grep $id "$OPTIMIZER_CONFIG" | awk -F '|' '{print $2}'`

	echo "psql -a -P pager=off -f $i -v optimizer=$optimizer"
	psql -a -P pager=off -f $i -v optimizer=$optimizer

	log
done
