#!/bin/bash

set -e

number_sessions=$1

if [ "$number_sessions" == "" ]; then
	echo "Error: you must provide the number of sessions as a parameter."
	echo "Example: ./rollout.sh 3"
	echo "This will execute three user sesions of TPC-DS queries."
	exit 1
fi

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

get_file_count()
{
	count=$(ls $PWD/../log/end_testing* 2> /dev/null | wc -l)
}

rm -f $PWD/../log/*testing*.log

for x in $(seq 1 $number_sessions); do
	session_log=$PWD/../log/testing_session_$x.log
	echo "$PWD/test.sh $x"
	$PWD/test.sh $x > $session_log 2>&1 < $session_log &
done

get_file_count
echo "Now executing queries. This make take a while."
echo -ne "Executing queries."
while [ "$count" -lt "$number_sessions" ]; do
	echo -ne "."
	sleep 5
	get_file_count
done
echo "done"
