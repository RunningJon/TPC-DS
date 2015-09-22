#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
LOGDIR=$PWD/..

echo $LOGDIR
for i in $(ls *.sql | grep -v report.sql); do
	table_name=`echo $i | awk -F '.' '{print $3}'`
	CMD="'cat $LOGDIR/log/rollout_$table_name.log'"
	echo "psql -a -f $i -v CMD=\"$CMD\""
	psql -a -f $i -v CMD="$CMD"
	echo ""
done

psql -P pager=off -f report.sql
