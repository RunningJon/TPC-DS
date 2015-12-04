#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

PARALLEL="$GP_SEGMENT_COUNT"

while read line; do
	#segment_id is zero based but dsdgen starts at 1
	CHILD=$(($GP_SEGMENT_ID + 1))
	GEN_DATA_SCALE="$line"
done < "${1:-/dev/stdin}"

DATA_DIRECTORY="$GP_SEG_DATADIR"/pivotalguru

if [ ! -d "$DATA_DIRECTORY" ]; then
	mkdir $DATA_DIRECTORY
fi

rm -f $DATA_DIRECTORY/*

cd $PWD
$PWD/dsdgen -scale $GEN_DATA_SCALE -dir $DATA_DIRECTORY -parallel $PARALLEL -child $CHILD -terminate n

# make sure there is a file in each directory so that gpfdist doesn't throw an error
declare -a tables=("call_center" "catalog_page" "catalog_returns" "catalog_sales" "customer" "customer_address" "customer_demographics" "date_dim" "household_demographics" "income_band" "inventory" "item" "promotion" "reason" "ship_mode" "store" "store_returns" "store_sales" "time_dim" "warehouse" "web_page" "web_returns" "web_sales" "web_site")

for i in "${tables[@]}"; do
	filename="$DATA_DIRECTORY/"$i"_"$CHILD"_"$PARALLEL".dat"
	echo $filename
	if [ ! -f $filename ]; then
		touch $filename
	fi
done
