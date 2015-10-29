#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

GEN_DATA_SCALE=$1
if [ "$GEN_DATA_SCALE" == "" ]; then
	echo "You must provide the scale as a parameter in terms of Gigabytes."
	echo "Example: ./rollout.sh 100"
	echo "This will create 100 GB of data for this test."
	exit 1
fi

get_count_generate_data()
{
	count=$(ps -ef | grep generate_data.sh | grep -v grep | wc -l)
}

step=gen_data
init_log $step
start_log
schema_name="tpcds"
table_name="gen_data"

for x in $(ps -ef | grep generate_data.sh | grep -v grep | awk -F ' ' '{print $2}'); do
	echo "killing $x"
	kill $x
	sleep .4
done

echo "Make data directories if needed..."
for f in $(cat $PWD/build_tables.txt); do
	directory=`echo $f | awk -F '|' '{print $2}'`

	if [[ ! -d "$PWD/../$directory" && ! -L "$PWD/../$directory" ]]; then
		echo "mkdir \"$PWD/../$directory\""
		mkdir "$PWD/../$directory"
	fi
done
echo ""
echo "Remove any previous data generation"
echo "rm -rf rm $PWD/../data*/*.dat"
rm -rf rm $PWD/../data*/*.dat
echo ""
for f in $(seq 1 $GEN_DATA_THREADS); do
	echo "nohup $PWD/generate_data.sh $GEN_DATA_THREADS $f $GEN_DATA_SCALE > $PWD/../log/generate_data_$f.log 2>&1 < $PWD/../log/generate_data_$f.log &"
	nohup $PWD/generate_data.sh $GEN_DATA_THREADS $f $GEN_DATA_SCALE > $PWD/../log/generate_data_$f.log 2>&1 < $PWD/../log/generate_data_$f.log &
done
sleep 1
echo ""
get_count_generate_data
echo "Now generating data.  This make take a while."
echo -ne "Generating data"
while [ "$count" -gt "0" ]; do
	echo -ne "."
	sleep 5
	get_count_generate_data
done

echo "Done generating data"
echo ""
echo "Fixing character set issue with the customer file"

for x in $(cat $PWD/../tables.txt); do
	table_name=`echo $x | awk -F '|' '{print $2}'`
	if [ "$table_name" == "customer" ]; then
		directory=`echo $x | awk -F '|' '{print $3}'`
	fi
done

for f in $(ls $PWD/../$directory/customer_[1-$GEN_DATA_THREADS]_$GEN_DATA_THREADS.dat); do
	echo "cat $f | recode iso-8859-1..u8 > $f.new"
	cat $f | recode iso-8859-1..u8 > $f.new
	echo "mv $f $f.bak"
	mv $f $f.bak
	echo "mv $f.new $f"
	mv $f.new $f
done

log

end_step $step
