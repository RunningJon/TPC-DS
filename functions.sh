#!/bin/bash
set -e

LOCAL_PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

source $LOCAL_PWD/variables.sh

source_bashrc()
{
	echo "############################################################################"
	echo "Source .bashrc"
	echo "############################################################################"
	source ~/.bashrc
	echo ""
}

get_version()
{
	#need to call source_bashrc first
	VERSION=$(psql -v ON_ERROR_STOP=1 -h $MASTER_HOST -t -A -c "SELECT CASE WHEN POSITION ('HAWQ 2' in version) > 0 AND POSITION ('Greenplum' IN version) > 0 THEN 'hawq_2' WHEN POSITION ('HAWQ 1' in version) > 0 AND POSITION ('Greenplum' IN version) > 0 THEN 'hawq_1' WHEN POSITION ('HAWQ' in version) = 0 AND POSITION ('Greenplum' IN version) > 0 THEN 'gpdb' ELSE 'OTHER' END FROM version();")

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

	printf "$id|$schema_name.$table_name|%02d:%02d:%02d.%03d\n" "$((S/3600%24))" "$((S/60%60))" "$((S%60))" "${M}" >> $LOCAL_PWD/log/$logfile

}

end_step()
{
	local logfile=end_$1.log
	touch $LOCAL_PWD/log/$logfile
}

create_directories()
{
	if [ ! -d $LOCAL_PWD/log ]; then
		echo "Creating log directory"
		mkdir $LOCAL_PWD/log
	fi
}

stop_gpfdist()
{
	for i in $(ps -ef | grep gpfdist | grep $GPFDIST_PORT | grep -v grep | awk -F ' ' '{print $2}'); do
		echo "Stopping gpfdist on pid: $i"
		kill $i
		sleep 2
	done
}

start_gpfdist()
{
	stop_gpfdist

	local GPFDIST_LOG=gpfdist_$GPFDIST_PORT.log

	echo "Starting gpfdist port $GPFDIST_PORT"
	echo "gpfdist -d $LOCAL_PWD -p $GPFDIST_PORT >> $LOCAL_PWD/log/$GPFDIST_LOG 2>&1 < $LOCAL_PWD/log/$GPFDIST_LOG &"
	gpfdist -d $LOCAL_PWD -p $GPFDIST_PORT >> $LOCAL_PWD/log/$GPFDIST_LOG 2>&1 < $LOCAL_PWD/log/$GPFDIST_LOG &
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
