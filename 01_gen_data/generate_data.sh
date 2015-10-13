#!/bin/bash

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../variables.sh

set -e
parallel=$1
child=$2

if [ "$child" == "" ]; then
	echo "Usage: generate_data.sh parallel child"
	echo "Example: ./generate_data.sh 4 1"
	exit 1
fi

for i in $(cat $PWD/build_tables.txt); do
	table_name=`echo $i | awk -F '|' '{print $1}'`
	directory=`echo $i | awk -F '|' '{print $2}'`
	directory=$PWD/../$directory

	echo "PWD/dsdgen -table $table_name -scale $GEN_DATA_SCALE -dir $directory -parallel $parallel -child $child -terminate n"
	$PWD/dsdgen -table $table_name -scale $GEN_DATA_SCALE -dir $directory -parallel $parallel -child $child -terminate n

done

echo "COMPLETE: dsdgen parallel $parallel child $child"
