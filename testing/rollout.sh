#!/bin/bash

set -e
GEN_DATA_SCALE=$1
number_sessions=$2
E9=$3

if [[ "$GEN_DATA_SCALE" == "" || "$number_sessions" == "" || "$E9" == "" ]]; then
	echo "Error: you must provide the scale, the number of sessions, and E9 true or false as parameters."
	echo "Example: ./rollout.sh 3000 5 false"
	echo "This will execute the TPC-DS queries for 3TB of data and 5 concurrent sessions that are dynamically."
	echo "created with dsqgen.  The E9 option will use the static queries and is only valid for 5 sessions."
	exit 1
fi

if [ "$E9" == "true" ]; then 
	if [ "$number_sessions" -ne "5" ]; then
		echo "E9 testing only supports 5 concurrent sessions."
		exit 1
	fi
fi

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

get_psql_count()
{
	psql_count=$(ps -ef | grep psql | grep testing | grep -v grep | wc -l)
}

get_file_count()
{
	file_count=$(ls $PWD/../log/end_testing* 2> /dev/null | wc -l)
}

get_file_count
if [ "$file_count" -ne "$number_sessions" ]; then

	rm -f $PWD/../log/end_testing_*.log
	rm -f $PWD/../log/testing*.log

	if [ "$E9" == "true" ]; then
		echo "Using static E9 queries"
	else
		rm -f $PWD/query_*.sql

		#create each session's directory
		sql_dir=$PWD/$session_id
		echo "sql_dir: $sql_dir"
		for i in $(seq 1 $number_sessions); do
			sql_dir="$PWD"/"$session_id""$i"
			echo "checking for directory $sql_dir"
			if [ ! -d "$sql_dir" ]; then
				echo "mkdir $sql_dir"
				mkdir $sql_dir
			fi
			echo "rm -f $sql_dir/*.sql"
			rm -f $sql_dir/*.sql
		done

		#Create queries
		echo "$PWD/dsqgen -streams $number_sessions -input $PWD/query_templates/templates.lst -directory $PWD/query_templates -dialect pivotal -scale $GEN_DATA_SCALE -verbose y -output $PWD"
		$PWD/dsqgen -streams $number_sessions -input $PWD/query_templates/templates.lst -directory $PWD/query_templates -dialect pivotal -scale $GEN_DATA_SCALE -verbose y -output $PWD

		#move the query_x.sql file to the correct session directory
		for i in $(ls $PWD/query_*.sql); do
			stream_number=$(basename $i | awk -F '.' '{print $1}' | awk -F '_' '{print $2}')
			#going from base 0 to base 1
			stream_number=$((stream_number+1))
			echo "stream_number: $stream_number"
			sql_dir=$PWD/$stream_number
			echo "mv $i $sql_dir/"
			mv $i $sql_dir/
		done
	fi

	for x in $(seq 1 $number_sessions); do
		session_log=$PWD/../log/testing_session_$x.log
		echo "$PWD/test.sh $GEN_DATA_SCALE $x $E9"
		$PWD/test.sh $GEN_DATA_SCALE $x $E9 > $session_log 2>&1 < $session_log &
	done

	sleep 2

	get_psql_count
	echo "Now executing queries. This make take a while."
	echo -ne "Executing queries."
	while [ "$psql_count" -gt "0" ]; do
		echo -ne "."
		sleep 5
		get_psql_count
	done
	echo "queries complete"
	echo ""

	get_file_count

	if [ "$file_count" -ne "$number_sessions" ]; then
		echo "The number of successfully completed sessions is less than expected!"
		echo "Please review the log files to determine which queries failed."
		exit 1
	fi
fi

$PWD/report.sh
