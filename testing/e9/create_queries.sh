#!/bin/bash
set -e
PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

number_of_queries="5"

create_files()
{
	for VALUE in $@; do
		i=$(($i+1))
		if [ "$i" -le "$number_of_queries" ]; then
			q=$(printf %02d $query_id)
			query=$(printf %02d $VALUE)
			target="$PWD/$i/$q.query.$query.sql"	

			source="$PWD/../../05_sql/*.e9.$query.sql"

			echo "cp $source $target"
			cp $source $target
		fi
	done
}

for d in $(seq 1 5); do
	echo "rm -f $PWD/$d/*"
	rm -f $PWD/$d/*
done

query_id="100"
while read LINE
do
	query_id=$(($query_id+1))
	i="0"
	create_files ${LINE}
done < stream_map.txt
