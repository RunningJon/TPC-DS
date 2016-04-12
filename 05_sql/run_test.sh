#!/bin/bash
set -e

for i in $(ls *.hive.*.sql); do
	echo "psql -A -q -t -P pager=off -v ON_ERROR_STOP=ON -v EXPLAIN_ANALYZE=\"\" -f $i | wc -l"
	tuples=$(psql -A -q -t -P pager=off -v ON_ERROR_STOP=ON -v EXPLAIN_ANALYZE="" -f $i | wc -l; exit ${PIPESTATUS[0]})
	#remove the extra line that \timing adds
	tuples=$(($tuples-1))
	echo $tuples
done
