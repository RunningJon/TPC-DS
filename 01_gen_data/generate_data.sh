#!/bin/bash

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../variables.sh
source_bashrc

set -e
PARALLEL=$1
CHILD=$2
GEN_DATA_SCALE=$3

if [ "$GEN_DATA_SCALE" == "" ]; then
	echo "Usage: generate_data.sh parallel child scale"
	echo "Example: ./generate_data.sh 4 1 100"
	echo "This creates 100GB of data using 4 parallel threads and this is thread number 1."
	echo "Example: ./generate_data.sh 4 2 100"
	echo "This creates 100GB of data using 4 parallel threads and this is thread number 2."
	echo "etc..."
	exit 1
fi

for i in $(cat $PWD/build_tables.txt); do
	table_name=`echo $i | awk -F '|' '{print $1}'`
	directory=`echo $i | awk -F '|' '{print $2}'`
	directory=$PWD/../$directory

	echo "PWD/dsdgen -table $table_name -scale $GEN_DATA_SCALE -dir $directory -parallel $PARALLEL -child $CHILD -terminate n"
	$PWD/dsdgen -table $table_name -scale $GEN_DATA_SCALE -dir $directory -parallel $PARALLEL -child $CHILD -terminate n

done

echo "COMPLETE: dsdgen parallel $PARALLEL child $CHILD scale $GEN_DATA_SCALE"
