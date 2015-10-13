#!/bin/bash
set -e
PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $PWD/../functions.sh

step=sql
init_log $step

for i in $(ls $PWD/*.sql); do
	start_log

	id=`echo $i | awk -F '.' '{print $1}'`
	schema_name=`echo $i | awk -F '.' '{print $2}'`
	table_name=`echo $i | awk -F '.' '{print $3}'`

	echo "psql -h $MASTER_HOST -a -P pager=off -v ON_ERROR_STOP=1 -f $i"
	psql -h $MASTER_HOST -a -P pager=off -v ON_ERROR_STOP=1 -f $i

	log
done

end_step $step
