#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

step=load
init_log $step

ADMIN_HOME=$(eval echo ~$ADMIN_USER)

copy_script()
{
	echo "copy the start and stop scripts to the hosts in the cluster"
	for i in $(psql -t -A -c "SELECT DISTINCT hostname FROM gp_segment_configuration ORDER BY hostname"); do
		echo "scp start_gpfdist.sh stop_gpfdist.sh $ADMIN_USER@$i:$ADMIN_HOME/"
		scp $PWD/start_gpfdist.sh $PWD/stop_gpfdist.sh $ADMIN_USER@$i:$ADMIN_HOME/
	done
}

create_tables()
{
	echo "create external web tables"
	EXECUTE="'$ADMIN_HOME/start_gpfdist.sh'"
	psql -a -v ON_ERROR_STOP=1 -v EXECUTE="$EXECUTE" -f $PWD/start_gpfdist.sql

	EXECUTE="'$ADMIN_HOME/stop_gpfdist.sh'"
	psql -a -v ON_ERROR_STOP=1 -v EXECUTE="$EXECUTE" -f $PWD/stop_gpfdist.sql
}

stop_gpfdist()
{
	echo "stop gpfdist"
	SEGMENT_COUNT=$(gpstate | grep "Total primary segments" | awk -F '=' '{print $2}')
	psql -a -v ON_ERROR_STOP=1 -v SEGMENT_COUNT="$SEGMENT_COUNT" -f $PWD/insert_stop_gpfdist.sql
}

start_gpfdist()
{
	stop_gpfdist

	echo "start gpfdist"
	SEGMENT_COUNT=$(gpstate | grep "Total primary segments" | awk -F '=' '{print $2}')
	psql -a -v ON_ERROR_STOP=1 -v SEGMENT_COUNT="$SEGMENT_COUNT" -f $PWD/insert_start_gpfdist.sql
}

copy_script
create_tables
start_gpfdist

for i in $(ls $PWD/0*.sql); do
	start_log

	id=`echo $i | awk -F '.' '{print $1}'`
	schema_name=`echo $i | awk -F '.' '{print $2}'`
	table_name=`echo $i | awk -F '.' '{print $3}'`

	echo "psql -v ON_ERROR_STOP=1 -f $i | grep INSERT | awk -F ' ' '{print \$3}'"
	tuples=$(psql -v ON_ERROR_STOP=1 -f $i | grep INSERT | awk -F ' ' '{print $3}')

	log $tuples
done

stop_gpfdist

#ANALYZE
echo "analyze tables and partitions with missing statistics"
psql -A -t -v ON_ERROR_STOP=1 -c "SELECT 'ANALYZE ' || n.nspname || '.' || c.relname || ';' FROM pg_class c JOIN pg_namespace n on c.relnamespace = n.oid WHERE n.nspname = 'tpcds' AND c.relname NOT IN (SELECT DISTINCT tablename FROM pg_partitions p WHERE schemaname = 'tpcds') AND c.reltuples::bigint = 0" | psql -a -e -v ON_ERROR_STOP=1

echo "analyze the root partition of partitioned tables with missing statistics"
psql -A -t -v ON_ERROR_STOP=1 -c "SELECT 'ANALYZE ROOTPARTITION ' || n.nspname || '.' || c.relname || ';' FROM pg_class c JOIN pg_namespace n on c.relnamespace = n.oid WHERE n.nspname = 'tpcds' AND c.relname IN (SELECT DISTINCT tablename FROM pg_partitions p WHERE schemaname = 'tpcds') AND c.reltuples::bigint = 0" | psql -a -e -v ON_ERROR_STOP=1

end_step $step
