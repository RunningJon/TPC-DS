#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc
step=single_user_reports

init_log $step

for i in $(ls $PWD/*.sql | grep -v report.sql); do
	table_name=`echo $i | awk -F '.' '{print $3}'`
	EXECUTE="'cat $PWD/../log/rollout_$table_name.log'"

	echo "psql -v ON_ERROR_STOP=ON -a -f $i -v EXECUTE=\"$EXECUTE\""
	psql -v ON_ERROR_STOP=ON -a -f $i -v EXECUTE="$EXECUTE"
	echo ""
done

echo "********************************************************************************"
echo "Generate Data"
echo "********************************************************************************"
psql -F $'\t' -A -v ON_ERROR_STOP=ON -P pager=off -f $PWD/gen_data_report.sql
echo ""
echo "********************************************************************************"
echo "Data Loads"
echo "********************************************************************************"
psql -F $'\t' -A -v ON_ERROR_STOP=ON -P pager=off -f $PWD/loads_report.sql
echo ""
echo "********************************************************************************"
echo "Analyze"
echo "********************************************************************************"
psql -F $'\t' -A -v ON_ERROR_STOP=ON -P pager=off -f $PWD/analyze_report.sql
echo ""
echo ""
echo "********************************************************************************"
echo "Queries"
echo "********************************************************************************"
psql -F $'\t' -A -v ON_ERROR_STOP=ON -P pager=off -f $PWD/queries_report.sql
echo ""
end_step $step
