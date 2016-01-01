#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

GEN_DATA_SCALE=$1
EXPLAIN_ANALYZE=$2
E9=$3

if [[ "$GEN_DATA_SCALE" == "" || "$EXPLAIN_ANALYZE" == "" || "$E9" == "" ]]; then
	echo "You must provide the scale as a parameter in terms of Gigabytes, true/false on running queries with EXPLAIN ANALYZE, "
	echo "and E9 true or false to run that version of TPC-DS."
	echo "Example: ./rollout.sh 100 false false"
	echo "This will create 100 GB of data for this test."
	exit 1
fi 

step=ddl
init_log $step
get_version

if [ "$E9" == "true" ]; then
	filter="e9"
else
	filter="tpcds"
fi

#Create tables 
for i in $(ls $PWD/*.$filter.*.sql); do
	id=`echo $i | awk -F '.' '{print $1}'`
	schema_name=`echo $i | awk -F '.' '{print $2}'`
	table_name=`echo $i | awk -F '.' '{print $3}'`
	start_log

	counter=0

	#if [[ "$VERSION" == "gpdb_4_2" || "$VERSION" == "gpdb_4_3" || "$VERSION" == "hawq_1" ]]; then
	#temporary for testing
	if [[ "$VERSION" == "gpdb_4_2" || "$VERSION" == "gpdb_4_3" ]]; then
		for z in $(cat $PWD/distribution.txt); do
			table_name2=`echo $z | awk -F '|' '{print $2}'`	
			if [ "$table_name2" == "$table_name" ]; then
				distribution=`echo $z | awk -F '|' '{print $3}'`
			fi
		done
		DISTRIBUTED_BY="DISTRIBUTED BY (""$distribution"")"
	else
		#HAWQ 2
		DISTRIBUTED_BY="DISTRIBUTED RANDOMLY"
	fi

	if [ "$E9" == "true" ]; then
		echo "psql -a -P pager=off -v ON_ERROR_STOP=ON -f $i -v E9_MEDIUM_STORAGE=\"$E9_MEDIUM_STORAGE\" -v E9_LARGE_STORAGE=\"$E9_LARGE_STORAGE\" -v DISTRIBUTED_BY=\"$DISTRIBUTED_BY\""
		psql -a -P pager=off -v ON_ERROR_STOP=ON -f $i -v E9_MEDIUM_STORAGE="$E9_MEDIUM_STORAGE" -v E9_LARGE_STORAGE="$E9_LARGE_STORAGE" -v DISTRIBUTED_BY="$DISTRIBUTED_BY"
	else
		echo "psql -a -P pager=off -v ON_ERROR_STOP=ON -f $i -v SMALL_STORAGE=\"$SMALL_STORAGE\" -v MEDIUM_STORAGE=\"$MEDIUM_STORAGE\" -v LARGE_STORAGE=\"$LARGE_STORAGE\" -v DISTRIBUTED_BY=\"$DISTRIBUTED_BY\""
		psql -a -P pager=off -v ON_ERROR_STOP=ON -f $i -v SMALL_STORAGE="$SMALL_STORAGE" -v MEDIUM_STORAGE="$MEDIUM_STORAGE" -v LARGE_STORAGE="$LARGE_STORAGE" -v DISTRIBUTED_BY="$DISTRIBUTED_BY"
	fi

	log
done

#external tables are the same for both Standard and E9 
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
		for x in $(cat $PWD/../segment_hosts.txt); do
			EXT_HOST=$x
			if [ "$counter" -eq "0" ]; then
				LOCATION="'"
			else
				LOCATION+="', '"
			fi
			LOCATION+="gpfdist://$EXT_HOST:$GPFDIST_PORT/"$table_name"_[0-9]*_[0-9]*.dat"

			counter=$(($counter + 1))
		done
	fi

	LOCATION+="'"

	echo "psql -a -P pager=off -v ON_ERROR_STOP=ON -f $i -v LOCATION=\"$LOCATION\""
	psql -a -P pager=off -v ON_ERROR_STOP=ON -f $i -v LOCATION="$LOCATION" 

	log
done

end_step $step
