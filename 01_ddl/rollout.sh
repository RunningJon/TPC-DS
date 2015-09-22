#!/bin/bash
set -e
source ../functions.sh
step=ddl
init $step
get_version

for i in $(ls *.sql); do
	start_log

	schema_name=`echo $i | awk -F '.' '{print $2}'`
	table_name=`echo $i | awk -F '.' '{print $3}'`
	LOCATION="'gpfdist://$HOSTNAME:$GPFDIST_PORT/$table_name.psv'"

	echo "psql -a -P pager=off -f $i -v LOCATION=$LOCATION -v SMALL_STORAGE=\"$SMALL_STORAGE\" -v MEDIUM_STORAGE=\"$MEDIUM_STORAGE\" -v LARGE_STORAGE=\"$LARGE_STORAGE\""
	psql -a -P pager=off -f $i -v LOCATION=$LOCATION -v SMALL_STORAGE="$SMALL_STORAGE" -v MEDIUM_STORAGE="$MEDIUM_STORAGE" -v LARGE_STORAGE="$LARGE_STORAGE"

	log
done

start_gpfdist

echo "store_sales is partitioned so dynamically determine partitions with this script"
./019.tpcds.store_sales.sh

stop_gpfdist
