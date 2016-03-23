#!/bin/bash

# not set on purpose because some versions don't have analyzedb
#set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

max_id=$(ls $PWD/*.sql | tail -1)
max_id=$(basename $max_id | awk -F '.' '{print $1}')

analyzedb --help 2>&1 > /dev/null
return_status="$?"

if [ "$return_status" -eq "0" ]; then
	dbname="$PGDATABASE"
	if [ "$dbname" == "" ]; then
		dbname="$ADMIN_USER"
	fi

	if [ "$PGPORT" == "" ]; then
		export PGPORT=5432
	fi

	start_log
	i="$max_id"
	schema_name="tpcds"
	table_name="tpcds"
	analyzedb -d $dbname -s tpcds --full -a
	tuples="0"
	log $tuples
else
	#get stats on all non-partitioned tables and all partitions
	for i in $(psql -A -t -v ON_ERROR_STOP=ON -c "SELECT lpad(row_number() over() + $max_id, 3, '0') || '.' || n.nspname || '.' || c.relname FROM pg_class c JOIN pg_namespace n on c.relnamespace = n.oid WHERE n.nspname = 'tpcds' AND c.relname NOT IN (SELECT DISTINCT tablename FROM pg_partitions p WHERE schemaname = 'tpcds') AND c.reltuples::bigint = 0"); do

		start_log
		id=`echo $i | awk -F '.' '{print $1}'`
		schema_name=`echo $i | awk -F '.' '{print $2}'`
		table_name=`echo $i | awk -F '.' '{print $3}'`

		echo "psql -a -v ON_ERROR_STOP=ON -c \"ANALYZE $schema_name.$table_name\""
		psql -a -v ON_ERROR_STOP=ON -c "ANALYZE $schema_name.$table_name"
		tuples="0"
		log $tuples
	done

	#analyze root partitions of partitioned tables
	for i in $(psql -A -t -v ON_ERROR_STOP=ON -c "SELECT lpad(row_number() over() + $max_id, 3, '0') || '.' || n.nspname || '.' || c.relname FROM pg_class c JOIN pg_namespace n on c.relnamespace = n.oid WHERE n.nspname = 'tpcds' AND c.relname IN (SELECT DISTINCT tablename FROM pg_partitions p WHERE schemaname = 'tpcds') AND c.reltuples::bigint = 0"); do
		start_log

		id=`echo $i | awk -F '.' '{print $1}'`
		schema_name=`echo $i | awk -F '.' '{print $2}'`
		table_name=`echo $i | awk -F '.' '{print $3}'`

		echo "psql -a -v ON_ERROR_STOP=ON -c \"ANALYZE ROOTPARTITION $schema_name.$table_name\""
		psql -a -v ON_ERROR_STOP=ON -c "ANALYZE ROOTPARTITION $schema_name.$table_name"
		tuples="0"
		log $tuples
	done
fi
