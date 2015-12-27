#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

for i in $(ls $PWD/*.sql | grep -v report.sql); do
	table_name=`echo $i | awk -F '.' '{print $3}'`
	EXECUTE="'cat $PWD/../log/rollout_$table_name.log'"

	echo "psql -v ON_ERROR_STOP=ON -a -f $i -v EXECUTE=\"$EXECUTE\""
	psql -v ON_ERROR_STOP=ON -a -f $i -v EXECUTE="$EXECUTE"
	echo ""
done

psql -q -t -A -v ON_ERROR_STOP=ON -P pager=off -f $PWD/detailed_report.sql -o $PWD/../log/detailed_report.csv
echo ""
psql -q -t -A -v ON_ERROR_STOP=ON -P pager=off -f $PWD/summary_report.sql -o $PWD/../log/summary_report.csv

echo "Detailed report located in $PWD/../log/detailed_report.csv"
echo "Summary report located in $PWD/../log/summary_report.csv"
