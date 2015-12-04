#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

step=sql
init_log $step

for i in $(ls $PWD/*.sql); do

	id=`echo $i | awk -F '.' '{print $1}'`
	schema_name=`echo $i | awk -F '.' '{print $2}'`
	table_name=`echo $i | awk -F '.' '{print $3}'`

	echo "psql -A -q -t -P pager=off -v ON_ERROR_STOP=1 -f $i | wc -l"
	start_log
	tuples=$(psql -A -q -t -P pager=off -v ON_ERROR_STOP=1 -f $i | wc -l)
	log $tuples
done

end_step $step
