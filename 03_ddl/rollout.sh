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

	id=`echo $i | awk -F '.' '{print $1}'`
	schema_name=`echo $i | awk -F '.' '{print $2}'`
	table_name=`echo $i | awk -F '.' '{print $3}'`

	counter=0
	for x in $(psql -t -A -c "SELECT hostname FROM gp_segment_configuration WHERE content >= 0 ORDER BY hostname"); do
		if [ "$counter" -eq "0" ]; then
			LOCATION="'"
		else
			LOCATION+="', '"
		fi
		GPFDIST_PORT=$((8000+$counter))
		LOCATION+="gpfdist://$x:$GPFDIST_PORT/"$table_name"_[0-9]_[0-9].dat"

		counter=$(($counter + 1))
	done

	LOCATION+="'"

	echo "psql -a -P pager=off -v ON_ERROR_STOP=1 -f $i -v LOCATION=\"$LOCATION\" -v SMALL_STORAGE=\"$SMALL_STORAGE\" -v MEDIUM_STORAGE=\"$MEDIUM_STORAGE\" -v LARGE_STORAGE=\"$LARGE_STORAGE\""
	psql -a -P pager=off -v ON_ERROR_STOP=1 -f $i -v LOCATION="$LOCATION" -v SMALL_STORAGE="$SMALL_STORAGE" -v MEDIUM_STORAGE="$MEDIUM_STORAGE" -v LARGE_STORAGE="$LARGE_STORAGE"

	log
done

end_step $step
