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

step=sql
init_log $step

if [ "$E9" == "true" ]; then
        filter="e9"
else
        filter="query"
fi

for i in $(ls $PWD/*.$filter.*.sql); do
	id=`echo $i | awk -F '.' '{print $1}'`
	schema_name=`echo $i | awk -F '.' '{print $2}'`
	table_name=`echo $i | awk -F '.' '{print $3}'`
	start_log

	if [ "$EXPLAIN_ANALYZE" == "false" ]; then
		echo "psql -A -q -t -P pager=off -v ON_ERROR_STOP=ON -v EXPLAIN_ANALYZE=\"\" -f $i | wc -l"
		tuples=$(psql -A -q -t -P pager=off -v ON_ERROR_STOP=ON -v EXPLAIN_ANALYZE="" -f $i | wc -l; exit ${PIPESTATUS[0]})
		#remove the extra line that \timing adds
		tuples=$(($tuples-1))
	else
		myfilename=$(basename $i | awk -F '.' '{print $3".explain_analyze"}')
		mylogfile=$PWD/../log/$myfilename.log
		echo "psql -A -q -t -P pager=off -v ON_ERROR_STOP=ON -v EXPLAIN_ANALYZE=\"EXPLAIN ANALYZE\" -f $i > $mylogfile"
		psql -A -q -t -P pager=off -v ON_ERROR_STOP=ON -v EXPLAIN_ANALYZE="EXPLAIN ANALYZE" -f $i > $mylogfile
		tuples="0"
	fi
	log $tuples
done

end_step $step
