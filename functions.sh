#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $PWD/variables.sh

get_version()
{
	VERSION=`psql -t -A -c "SELECT CASE WHEN POSITION ('HAWQ 2' in version) > 0 AND POSITION ('Greenplum' IN version) > 0 THEN 'hawq_2' WHEN POSITION ('HAWQ 1' in version) > 0 AND POSITION ('Greenplum' IN version) > 0 THEN 'hawq_1' WHEN POSITION ('HAWQ' in version) = 0 AND POSITION ('Greenplum' IN version) > 0 THEN 'gpdb' ELSE 'OTHER' END FROM version();"`

	if [[ "$VERSION" == *"hawq"* ]]; then
		SMALL_STORAGE="appendonly=true, orientation=parquet"
		MEDIUM_STORAGE="appendonly=true, orientation=parquet"
		LARGE_STORAGE="appendonly=true, orientation=parquet"

		if [ "$VERSION" == "hawq_2" ]; then
			OPTIMIZER_CONFIG="$PWD/optimizer_hawq_2.txt"
		elif [ "$VERSION" == "hawq_1" ]; then
			OPTIMIZER_CONFIG="$PWD/optimizer_hawq_1.txt"
		fi
	else
		SMALL_STORAGE="appendonly=true, orientation=column"
		MEDIUM_STORAGE="appendonly=true, orientation=column"
		LARGE_STORAGE="appendonly=true, orientation=column"
		OPTIMIZER_CONFIG="$PWD/optimizer_gpdb.txt"
	fi

}
init()
{
	logfile=rollout_$1.log
	rm -f $PWD/log/$logfile
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

	id=`echo $i | awk -F '.' ' { print $1 } '`

	printf "$id|$schema_name.$table_name|%02d:%02d:%02d.%03d\n" "$((S/3600%24))" "$((S/60%60))" "$((S%60))" "${M}" >> $PWD/log/$logfile

}

create_directories()
{
	if [ ! -d $PWD/log ]; then
		echo "Creating log directory"
		mkdir $PWD/log
	fi
}

start_gpfdist()
{
	create_directories

	local count=`ps -ef | grep gpfdist | grep $GPFDIST_PORT | grep -v grep | wc -l`
	if [ "$count" -eq "1" ]; then
		gpfdist_pid=`ps -ef | grep gpfdist | grep $GPFDIST_PORT | grep -v grep | awk -F ' ' '{print $2}'`
		if [ "$gpfdist_pid" != "" ]; then
			echo "Stopping gpfdist on pid: $gpfdist_pid"
			kill $gpfdist_pid
			sleep 2
		fi
	fi
	echo "Starting gpfdist port $GPFDIST_PORT"
	echo "gpfdist -d $PWD/data -p $GPFDIST_PORT >> $PWD/log/$GPFDIST_LOG 2>&1 < $PWD/log/$GPFDIST_LOG &"
	gpfdist -d $PWD/data -p $GPFDIST_PORT >> $PWD/log/$GPFDIST_LOG 2>&1 < $PWD/log/$GPFDIST_LOG &
	gpfdist_pid=$!

	# check gpfdist process was started
	if [ "$gpfdist_pid" -ne "0" ]; then
		sleep 0.4
		count=`ps -ef 2> /dev/null | grep -v grep | awk -F ' ' '{print $2}' | grep $gpfdist_pid | wc -l`
		if [ "$count" -eq "1" ]; then
			echo "gpfdist started on port $GPFDIST_PORT"
		else
			echo "ERROR: gpfdist couldn't start on port $GPFDIST_PORT"
			exit 1
		fi
	fi
}

stop_gpfdist()
{
	if [ "$gpfdist_pid" != "" ]; then
		echo "Stopping gpfdist on pid: $gpfdist_pid"
		kill $gpfdist_pid
	fi
}
