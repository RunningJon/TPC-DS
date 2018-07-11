#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc
step="multi_user_reports"

init_log $step

get_version
if [[ "$VERSION" == *"gpdb"* ]]; then
	filter="gpdb"
elif [ "$VERSION" == "postgresql" ]; then
	filter="postgresql"
else
	echo "ERROR: Unsupported VERSION!"
	exit 1
fi

for i in $(ls $PWD/*.$filter.*.sql); do
	echo "psql -a -f $i"
	psql -a -f $i
	echo ""
done

filename=$(ls $PWD/*.copy.*.sql)

for i in $(ls $PWD/../log/rollout_testing_*); do
	logfile="'""$i""'"
	
        echo "psql -a -f $filename -v LOGFILE=\"$logfile\""
        psql -a -f $filename -v LOGFILE="$logfile"
done

psql -t -A -c "select 'analyze ' || n.nspname || '.' || c.relname || ';' from pg_class c join pg_namespace n on n.oid = c.relnamespace and n.nspname = 'tpcds_testing'" | psql -t -A -e

psql -F $'\t' -A -P pager=off -f $PWD/detailed_report.sql
echo ""

end_step $step
