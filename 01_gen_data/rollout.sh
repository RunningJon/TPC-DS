#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

GEN_DATA_SCALE=$1

if [ "$GEN_DATA_SCALE" == "" ]; then
	echo "You must provide the scale as a parameter in terms of Gigabytes." 
	echo "Example: ./rollout.sh 100"
	echo "This will create 100 GB of data for this test."
	exit 1
fi

get_count_generate_data()
{
	count=$(ps -ef | grep insert_gen_data.sql | grep -v grep | wc -l)
}

create_table()
{
	EXECUTE="'$ADMIN_HOME/generate_data.sh'"
	psql -a -v ON_ERROR_STOP=1 -v EXECUTE="$EXECUTE" -f $PWD/gen_data.sql
}

gen_data()
{
	SEGMENT_COUNT=$(gpstate | grep "Total primary segments" | awk -F '=' '{print $2}')
	nohup psql -a -v ON_ERROR_STOP=1 -v SEGMENT_COUNT="$SEGMENT_COUNT" -v GEN_DATA_SCALE="$GEN_DATA_SCALE" -f $PWD/insert_gen_data.sql > $PWD/../log/generate_data.log 2>&1 < $PWD/../log/generate_data.log &
}

copy_script()
{
	#copy the generate_data.sh script to the hosts in the cluster
	for i in $(psql -t -A -c "SELECT DISTINCT hostname FROM gp_segment_configuration ORDER BY hostname"); do
		echo "scp $PWD/generate_data.sh $ADMIN_USER@$i:$ADMIN_HOME/"
		scp $PWD/generate_data.sh $ADMIN_USER@$i:$ADMIN_HOME/
	done
}

kill_orphaned_data_gen()
{
	for x in $(ps -ef | grep insert_gen_data | grep -v grep | awk -F ' ' '{print $2}'); do
		echo "killing $x"
		kill $x
		sleep .4
	done
}

step=gen_data
init_log $step
start_log
schema_name="tpcds"
table_name="gen_data"

kill_orphaned_data_gen
create_table
copy_script
gen_data $GEN_DATA_SCALE

echo ""
get_count_generate_data
echo "Now generating data.  This make take a while."
echo -ne "Generating data"
while [ "$count" -gt "0" ]; do
	echo -ne "."
	sleep 5
	get_count_generate_data
done

echo "Done generating data"
echo ""

echo "Generate queries based on scale"
$PWD/generate_queries.sh $GEN_DATA_SCALE

log

end_step $step
