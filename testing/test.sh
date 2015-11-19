#!/bin/bash

set -e

session_id=$1

if [ "$session_id" == "" ]; then
	echo "Error: you must provide which session number as a parameter."
	echo "Example: ./test.sh 3"
	echo "This will execute the TPC-DS queries for session number 3."
	exit 1
fi

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

step=testing_$session_id

init_log $step

for i in $(psql -v ON_ERROR_STOP=1 -h $MASTER_HOST -P pager=off -t -A -c "select lpad(i, 2, '0') as i from generate_series(1,99) as i order by random()"); do

	start_log
	id=$i
	schema_name=$session_id
	table_name=$i

	filename=$PWD/../05_sql/1$i.query.$i.sql

	echo "psql -h $MASTER_HOST -a -P pager=off -v ON_ERROR_STOP=1 -f $filename"
	psql -h $MASTER_HOST -a -P pager=off -v ON_ERROR_STOP=1 -f $filename

	log
done

end_step $step
