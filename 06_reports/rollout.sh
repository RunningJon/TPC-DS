#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

for i in $(ls $PWD/*.sql | grep -v report.sql); do
	table_name=`echo $i | awk -F '.' '{print $3}'`
	CMD="'cat $PWD/../log/rollout_$table_name.log'"
	echo "psql -h $MASTER_HOST -a -f $i -v CMD=\"$CMD\""
	psql -h $MASTER_HOST -a -f $i -v CMD="$CMD"
	echo ""
done

psql -h $MASTER_HOST -P pager=off -f $PWD/detailed_report.sql
echo ""
psql -h $MASTER_HOST -P pager=off -f $PWD/summary_report.sql
