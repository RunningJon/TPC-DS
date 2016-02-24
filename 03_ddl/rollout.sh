#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

GEN_DATA_SCALE=$1
EXPLAIN_ANALYZE=$2
SQL_VERSION=$3
RANDOM_DISTRIBUTION=$4

if [[ "$GEN_DATA_SCALE" == "" || "$EXPLAIN_ANALYZE" == "" || "$SQL_VERSION" == "" || "$RANDOM_DISTRIBUTION" == "" ]]; then
	echo "You must provide the scale as a parameter in terms of Gigabytes, true/false to run queries with EXPLAIN ANALYZE option, the SQL_VERSION, and true/false to use random distrbution."
	echo "Example: ./rollout.sh 100 false false false"
	echo "This will create 100 GB of data for this test, not run EXPLAIN ANALYZE, use standard TPC-DS, and not use random distribution."
	exit 1
fi

step=ddl
init_log $step
get_version

#Create tables 
for i in $(ls $PWD/*.$SQL_VERSION.*.sql); do
	id=`echo $i | awk -F '.' '{print $1}'`
	schema_name=`echo $i | awk -F '.' '{print $2}'`
	table_name=`echo $i | awk -F '.' '{print $3}'`
	start_log

	counter=0

	if [ "$RANDOM_DISTRIBUTION" == "true" ]; then
		DISTRIBUTED_BY="DISTRIBUTED RANDOMLY"
	else
		for z in $(cat $PWD/distribution.txt); do
			table_name2=`echo $z | awk -F '|' '{print $2}'`	
			if [ "$table_name2" == "$table_name" ]; then
				distribution=`echo $z | awk -F '|' '{print $3}'`
			fi
		done
		DISTRIBUTED_BY="DISTRIBUTED BY (""$distribution"")"
	fi

	if [ "$SQL_VERSION" == "e9" ]; then
		echo "psql -a -P pager=off -v ON_ERROR_STOP=ON -f $i -v E9_MEDIUM_STORAGE=\"$E9_MEDIUM_STORAGE\" -v E9_LARGE_STORAGE=\"$E9_LARGE_STORAGE\" -v DISTRIBUTED_BY=\"$DISTRIBUTED_BY\""
		psql -a -P pager=off -v ON_ERROR_STOP=ON -f $i -v E9_MEDIUM_STORAGE="$E9_MEDIUM_STORAGE" -v E9_LARGE_STORAGE="$E9_LARGE_STORAGE" -v DISTRIBUTED_BY="$DISTRIBUTED_BY"
	else
		echo "psql -a -P pager=off -v ON_ERROR_STOP=ON -f $i -v SMALL_STORAGE=\"$SMALL_STORAGE\" -v MEDIUM_STORAGE=\"$MEDIUM_STORAGE\" -v LARGE_STORAGE=\"$LARGE_STORAGE\" -v DISTRIBUTED_BY=\"$DISTRIBUTED_BY\""
		psql -a -P pager=off -v ON_ERROR_STOP=ON -f $i -v SMALL_STORAGE="$SMALL_STORAGE" -v MEDIUM_STORAGE="$MEDIUM_STORAGE" -v LARGE_STORAGE="$LARGE_STORAGE" -v DISTRIBUTED_BY="$DISTRIBUTED_BY"
	fi

	log
done

#external tables are the same for all SQL_VERSION
for i in $(ls $PWD/*.ext_tpcds.*.sql); do
	start_log

	id=`echo $i | awk -F '.' '{print $1}'`
	schema_name=`echo $i | awk -F '.' '{print $2}'`
	table_name=`echo $i | awk -F '.' '{print $3}'`

	counter=0

	if [[ "$VERSION" == "gpdb_4_2" || "$VERSION" == "gpdb_4_3" || "$VERSION" == "hawq_1" ]]; then
		for x in $(psql -A -t -c "select rank() over (partition by hostname order by path), trim(hostname) from data_dir order by hostname"); do
			CHILD=$(echo $x | awk -F '|' '{print $1}')
			EXT_HOST=$(echo $x | awk -F '|' '{print $2}')
			PORT=$(($GPFDIST_PORT + $CHILD))

			if [ "$counter" -eq "0" ]; then
				LOCATION="'"
			else
				LOCATION+="', '"
			fi
			LOCATION+="gpfdist://$EXT_HOST:$PORT/"$table_name"_[0-9]*_[0-9]*.dat"

			counter=$(($counter + 1))
		done
	else
		#HAWQ 2
		segment_count=$(cat $PWD/../segment_hosts.txt | wc -l)
		segment_count=$(($segment_count * 8))
		for x in $(cat $PWD/../segment_hosts.txt); do
			EXT_HOST=$x
			for y in $(seq 1 8); do
				PORT=$(($GPFDIST_PORT + $y))
				if [ "$counter" -eq "0" ]; then
					LOCATION="'"
				else
					LOCATION+="', '"
				fi
				LOCATION+="gpfdist://$EXT_HOST:$PORT/"$table_name"_[0-9]*_[0-9]*.dat"

				counter=$(($counter + 1))
			done
		done
	fi

	LOCATION+="'"

	echo "psql -a -P pager=off -v ON_ERROR_STOP=ON -f $i -v LOCATION=\"$LOCATION\""
	psql -a -P pager=off -v ON_ERROR_STOP=ON -f $i -v LOCATION="$LOCATION" 

	log
done

end_step $step
