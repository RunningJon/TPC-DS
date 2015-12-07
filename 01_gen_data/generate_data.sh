#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

GEN_DATA_SCALE=$1
CHILD=$2
PARALLEL=$3
GEN_DATA_PATH=$4

DATA_DIRECTORY="$GEN_DATA_PATH"/pivotalguru

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
