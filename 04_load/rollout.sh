#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

step=load
init_log $step

start_gpfdist

for i in $(ls $PWD/*.sql); do
	start_log

	schema_name=`echo $i | awk -F '.' '{print $2}'`
	table_name=`echo $i | awk -F '.' '{print $3}'`

	echo "psql -h $MASTER_HOST -a -v ON_ERROR_STOP=1 -f $i"
	psql -h $MASTER_HOST -a -v ON_ERROR_STOP=1 -f $i

	log
done

stop_gpfdist

#ANALYZE
psql -h $MASTER_HOST -A -t -v ON_ERROR_STOP=1 -c "SELECT 'ANALYZE ' || n.nspname || '.' || c.relname || ';' FROM pg_class c JOIN pg_namespace n on c.relnamespace = n.oid WHERE n.nspname = 'tpcds' AND c.relname NOT IN (SELECT DISTINCT tablename FROM pg_partitions p WHERE schemaname = 'tpcds') AND c.reltuples::bigint = 0" | psql -a -h $MASTER_HOST -e -v ON_ERROR_STOP=1

psql -h $MASTER_HOST -A -t -v ON_ERROR_STOP=1 -c "SELECT 'ANALYZE ROOTPARTITION ' || n.nspname || '.' || c.relname || ';' FROM pg_class c JOIN pg_namespace n on c.relnamespace = n.oid WHERE n.nspname = 'tpcds' AND c.relname IN (SELECT DISTINCT tablename FROM pg_partitions p WHERE schemaname = 'tpcds') AND c.reltuples::bigint = 0" | psql -a -h $MASTER_HOST -e -v ON_ERROR_STOP=1

end_step $step
