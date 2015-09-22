#!/bin/bash
set -e
source ../functions.sh

step=load
init $step

start_gpfdist

for i in $(ls *.sql); do
	start_log

	schema_name=`echo $i | awk -F '.' '{print $2}'`
	table_name=`echo $i | awk -F '.' '{print $3}'`

	echo "psql -a -f $i"
	psql -a -f $i

	log
done

stop_gpfdist

echo "analyze the partitioned table"
echo "psql -c \"ANALYZE tpcds.store_sales;\""
psql -c "ANALYZE tpcds.store_sales;"
