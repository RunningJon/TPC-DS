#!/bin/bash
set -e

count=$(alias | grep -w grep | wc -l)
if [ "$count" -gt "0" ]; then
	unalias grep
fi
count=$(alias | grep -w ls | wc -l)
if [ "$count" -gt "0" ]; then
	unalias ls
fi

export LD_PRELOAD=/lib64/libz.so.1 ps

LOCAL_PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
OSVERSION=`uname`
ADMIN_USER=`whoami`
ADMIN_HOME=$(eval echo ~$ADMIN_USER)
MASTER_HOST=$(hostname -s)

get_gpfdist_port()
{
	all_ports=$(psql -t -A -c "select min(case when role = 'p' then port else 999999 end), min(case when role = 'm' then port else 999999 end) from gp_segment_configuration where content >= 0")
	primary_base=$(echo $all_ports | awk -F '|' '{print $1}' | head -c1)
	mirror_base=$(echo $all_ports | awk -F '|' '{print $2}' | head -c1)

	for i in $(seq 4 9); do
		if [ "$primary_base" -ne "$i" ] && [ "$mirror_base" -ne "$i" ]; then
			GPFDIST_PORT="$i""000"
			break
		fi
	done
}

source_bashrc()
{
	if [ -f ~/.bashrc ]; then
		# don't fail if an error is happening in the admin's profile
		source ~/.bashrc || true
	fi
	count=$(grep -v "^#" ~/.bashrc | grep "greenplum_path" | wc -l)
	if [ "$count" -eq "0" ]; then
		get_version
		if [[ "$VERSION" == *"gpdb"* ]]; then
			echo "$startup_file does not contain greenplum_path.sh"
			echo "Please update your $startup_file for $ADMIN_USER and try again."
			exit 1
		fi
	fi
}
get_version()
{
	#need to call source_bashrc first
	VERSION=$(psql -v ON_ERROR_STOP=1 -t -A -c "SELECT CASE WHEN POSITION ('Greenplum Database 4.3' IN version) > 0 THEN 'gpdb_4_3' WHEN POSITION ('Greenplum Database 5' IN version) > 0 THEN 'gpdb_5' WHEN POSITION ('Greenplum Database 6' IN version) > 0 THEN 'gpdb_6' ELSE 'postgresql' END FROM version();") 
	if [[ "$VERSION" == *"gpdb"* ]]; then
		quicklz_test=$(psql -v ON_ERROR_STOP=1 -t -A -c "SELECT COUNT(*) FROM pg_compression WHERE compname = 'quicklz'")
		if [ "$quicklz_test" -eq "1" ]; then
			SMALL_STORAGE="appendonly=true, orientation=column"
			MEDIUM_STORAGE="appendonly=true, orientation=column"
			LARGE_STORAGE="appendonly=true, orientation=column, compresstype=quicklz"
		else
			SMALL_STORAGE="appendonly=true, orientation=column"
			MEDIUM_STORAGE="appendonly=true, orientation=column"
			LARGE_STORAGE="appendonly=true, orientation=column, compresstype=zlib, compresslevel=4"
		fi
	else
		SMALL_STORAGE=""
		MEDIUM_STORAGE=""
		LARGE_STORAGE=""
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

	if [[ "$VERSION" == *"gpdb"* ]]; then
		psql -v ON_ERROR_STOP=1 -t -A -c "SELECT DISTINCT hostname FROM gp_segment_configuration WHERE role = 'p' AND content >= 0" -o $LOCAL_PWD/segment_hosts.txt
	else
		#must be PostgreSQL
		echo $MASTER_HOST > $LOCAL_PWD/segment_hosts.txt
	fi
}
