#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

step=ddl
init_log $step
get_version

for i in $(ls $PWD/*.sql); do
	start_log

	schema_name=`echo $i | awk -F '.' '{print $2}'`
	table_name=`echo $i | awk -F '.' '{print $3}'`

	for x in $(cat $PWD/../tables.txt); do
		table_name2=`echo $x | awk -F '|' '{print $2}'`
		if [ "$table_name2" == "$table_name" ]; then
			directory=`echo $x | awk -F '|' '{print $3}'`
		fi
	done
	
	file_name=$table_name
	file_name+="_[1-$GEN_DATA_THREADS]_$GEN_DATA_THREADS.dat"
	LOCATION="'gpfdist://$HOSTNAME:$GPFDIST_PORT/$directory/$file_name'"

	echo "psql -h $MASTER_HOST -a -P pager=off -v ON_ERROR_STOP=1 -f $i -v LOCATION=\"$LOCATION\" -v SMALL_STORAGE=\"$SMALL_STORAGE\" -v MEDIUM_STORAGE=\"$MEDIUM_STORAGE\" -v LARGE_STORAGE=\"$LARGE_STORAGE\""
	psql -h $MASTER_HOST -a -P pager=off -v ON_ERROR_STOP=1 -f $i -v LOCATION="$LOCATION" -v SMALL_STORAGE="$SMALL_STORAGE" -v MEDIUM_STORAGE="$MEDIUM_STORAGE" -v LARGE_STORAGE="$LARGE_STORAGE"

	log
done

end_step $step
