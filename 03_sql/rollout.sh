#!/bin/bash
set -e
source ../functions.sh

step=sql
init $step

for i in $(ls *.sql); do
	start_log

	schema_name=`echo $i | awk -F '.' '{print $2}'`
	table_name=`echo $i | awk -F '.' '{print $3}'`

	echo "psql -a -P pager=off -f $i"
	psql -a -P pager=off -f $i

	log
done
