#!/bin/bash

set -e
PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/functions.sh
source_bashrc

GEN_DATA_SCALE=$1
EXPLAIN_ANALYZE=$2
E9=$3
RANDOM_DISTRIBUTION=$4
VERSION=$5

if [[ "$GEN_DATA_SCALE" == "" || "$EXPLAIN_ANALYZE" == "" || "$E9" == "" || "$RANDOM_DISTRIBUTION" == "" || "$VERSION" == "" ]]; then
	echo "You must provide the scale as a parameter in terms of Gigabytes, true/false to run queries with EXPLAIN ANALYZE option, E9 true or false to use their version of TPC-DS, and true/false to use random distrbution."
	echo "Example: ./rollout.sh 100 false false false 1.4"
	echo "This will create 100 GB of data for this test, not run EXPLAIN ANALYZE, use standard TPC-DS, not use random distribution, and use version 1.4 of the TPC-DS benchmark."
	exit 1
fi

QUIET=$6

create_directories()
{
	if [ ! -d $LOCAL_PWD/log ]; then
		echo "Creating log directory"
		mkdir $LOCAL_PWD/log
	fi
}

create_directories

clear

echo "TPC-DS Script for Pivotal Greenplum Database and Pivotal HAWQ."
echo ""
echo "If you need to change any variables, exit this script, update functions.sh,"
echo "and restart tpcds.sh."
echo ""
echo "Skip-Completed: The script will execute each step in order.  If the script fails and is restarted,"
echo "the script will skip completed steps."
echo ""
echo "Smart: The script will execute the DDL, Load, SQL, and Reports steps but skip the TPC-DS compile, "
echo "data generation, and database initialization steps if the steps have completed before.  This is "
echo "useful when you may want to re-run the TPC-DS scripts but not go through the data generation again."
echo ""
echo "FORCE: The script will run all steps, regardless if it has run successfully before or"
echo "if some steps have already completed.  This would be useful if you wish to change"
echo "the size of the TPC-DS test."
echo ""
if [ "$QUIET" == "" ]; then
	PS3='Start Skip-Completed, Smart, FORCE, or Quit?'
	options=("Skip-Completed" "Smart" "FORCE" "Quit")
	select opt in "${options[@]}"
	do
	    case $opt in
		"Skip-Completed")
			start_level="0"
			break
			;;
		"Smart")
			start_level="1"
			break
			;;
		"FORCE")
			start_level="2"
			break
			;;
		"Quit")
			exit 0
			;;
		*) echo invalid option;;
	    esac
	done
else
	#running in quiet mode so run in Smart mode
	start_level="1"
fi

if [ "$start_level" -eq 1 ]; then
	rm -f $PWD/log/end_ddl.log
	rm -f $PWD/log/end_load.log
	rm -f $PWD/log/end_sql.log
	rm -f $PWD/log/end_testing_*.log
fi

if [ "$start_level" -eq 2 ]; then
	rm -f $PWD/log/end_*.log
fi

for i in $(ls -d $PWD/0*); do
	echo "$i/rollout.sh"
	$i/rollout.sh $GEN_DATA_SCALE $EXPLAIN_ANALYZE $E9 $RANDOM_DISTRIBUTION $VERSION
done
