#!/bin/bash
set -e

LOCAL_PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
OSVERSION=`uname`
ADMIN_USER=`whoami`
ADMIN_HOME=$(eval echo ~$ADMIN_USER)
GPFDIST_PORT=9000

source_bashrc()
{
	echo "source .bashrc"
	source ~/.bashrc
	echo ""
}

get_version()
{
	#need to call source_bashrc first
	VERSION=$(psql -v ON_ERROR_STOP=1 -t -A -c "SELECT CASE WHEN POSITION ('HAWQ 2' in version) > 0 AND POSITION ('Greenplum' IN version) > 0 THEN 'hawq_2' WHEN POSITION ('HAWQ 1' in version) > 0 AND POSITION ('Greenplum' IN version) > 0 THEN 'hawq_1' WHEN POSITION ('HAWQ' in version) = 0 AND POSITION ('Greenplum' IN version) > 0 THEN 'gpdb' ELSE 'OTHER' END FROM version();")

	if [[ "$VERSION" == *"hawq"* ]]; then
		SMALL_STORAGE="appendonly=true, orientation=parquet"
		MEDIUM_STORAGE="appendonly=true, orientation=parquet"
		LARGE_STORAGE="appendonly=true, orientation=parquet"
	else
		SMALL_STORAGE="appendonly=true, orientation=column"
		MEDIUM_STORAGE="appendonly=true, orientation=column"
		LARGE_STORAGE="appendonly=true, orientation=column"
	fi

}

init_log()
{
	if [ -f $LOCAL_PWD/log/end_$1.log ]; then
		exit 0
	fi

	logfile=rollout_$1.log
	rm -f $LOCAL_PWD/log/$logfile
}

start_log()
{
	if [ "$OSVERSION" == "Linux" ]; then
		T="$(date +%s%N)"
	else
		T="$(date +%s)"
	fi
}

log()
{
	#duration
	if [ "$OSVERSION" == "Linux" ]; then
		T="$(($(date +%s%N)-T))"
		# seconds
		S="$((T/1000000000))"
		# milliseconds
		M="$((T/1000000))"
	else
		#must be OSX which doesn't have nano-seconds
		T="$(($(date +%s)-T))"
		S=$T
		M=0
	fi

	#this is done for steps that don't have id values
	if [ "$id" == "" ]; then
		id="1"
	else
		id=$(basename $i | awk -F '.' '{print $1}')
	fi

	tuples=$1
	if [ "$tuples" == "" ]; then
		tuples="0"
	fi

	printf "$id|$schema_name.$table_name|$tuples|%02d:%02d:%02d.%03d\n" "$((S/3600%24))" "$((S/60%60))" "$((S%60))" "${M}" >> $LOCAL_PWD/log/$logfile

}

end_step()
{
	local logfile=end_$1.log
	touch $LOCAL_PWD/log/$logfile
}

create_hosts_file()
{
	get_version

	if [[ "$VERSION" == "gpdb" || "$VERSION" == "hawq_1" ]]; then
		psql -t -A -v ON_ERROR_STOP=1 -c "SELECT DISTINCT hostname FROM gp_segment_configuration WHERE role = 'p' AND content >= 0" -o $LOCAL_PWD/segment_hosts.txt
	else
		#must be HAWQ 2 which doesn't have content column
		psql -t -A -v ON_ERROR_STOP=1 -c "SELECT DISTINCT hostname FROM gp_segment_configuration WHERE role = 'p'" -o $LOCAL_PWD/segment_hosts.txt
	fi
}
