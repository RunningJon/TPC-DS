#!/bin/bash

set -e
PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/functions.sh
source_bashrc

GEN_DATA_SCALE=$1

if [ "$GEN_DATA_SCALE" == "" ]; then
	echo "You must provide the scale as a parameter in terms of Gigabytes."
	echo "Example: ./rollout.sh 100"
	echo "This will create 100 GB of data for this test."
	exit 1
fi

create_directories

clear

echo "TPC-DS Script for Pivotal Greenplum Database and Pivotal HAWQ."
echo ""
echo "In the event of an error, the script will stop but the script can be re-run.  When"
echo "re-run, the script will automatically restart at the correct step.  You can also"
echo "FORCE the script to run all steps, regardless if it has run successfully before or"
echo "if some steps have already completed.  This would be useful if you wish to change"
echo "the size of the TPC-DS test."
echo ""
echo "To change the size of the TPC-DS dataset, edit the variables.sh file before running"
echo "this script."
echo ""
PS3='Start Normally or FORCE from the beginning? '
options=("Normal" "FORCE" "Quit")
select opt in "${options[@]}"
do
    case $opt in
	"Normal")
		force="0"
		break
		;;
	"FORCE")
		force="1"
		break
		;;
	"Quit")
		exit 0
		;;
	*) echo invalid option;;
    esac
done

if [ "$force" -eq 1 ]; then
	rm -f $PWD/log/end_*.log
fi

for i in $(ls -d $PWD/0*); do
	echo "$i/rollout.sh"
	$i/rollout.sh $GEN_DATA_SCALE
done
