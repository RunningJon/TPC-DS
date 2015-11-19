#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

step=init
init_log $step
start_log
schema_name="tpcds"
table_name="init"

update_config="0"

#check search_path
counter=$(psql -v ON_ERROR_STOP=1 -t -A -h $MASTER_HOST -c "show search_path" | grep tpcds | wc -l)
if [ "$counter" -eq "0" ]; then
	psql -v ON_ERROR_STOP=1 -h $MASTER_HOST -c "ALTER USER gpadmin SET search_path=tpcds,public;"
fi

#check optimizer
counter=$(psql -v ON_ERROR_STOP=1 -t -A -h $MASTER_HOST -c "show optimizer" | grep on | wc -l)
if [ "$counter" -eq "0" ]; then
	if [ "$MASTER_HOST" <> "$HOSTNAME" ]; then
		echo "Unable to proceed.  Log into the master host and execute the following command:"
		echo "gpconfig -c optimizer -v on --masteronly"
		exit 1
	else
		echo "enabling optimizer"
		gpconfig -c optimizer -v on --masteronly
		update_config="1"
	fi
fi

#check analyze_root_partition
counter=$(psql -v ON_ERROR_STOP=1 -t -A -h $MASTER_HOST -c "show optimizer_analyze_root_partition" | grep on | wc -l)
if [ "$counter" -eq "0" ]; then
	if [ "$MASTER_HOST" <> "$HOSTNAME" ]; then
		echo "Unable to proceed.  Log into the master host and execute the following command:"
		echo "gpconfig -c optimizer_analyze_root_partition -v on --masteronly"
		exit 1
	else
		echo "enabling analyze_root_partition"
		gpconfig -c optimizer_analyze_root_partition -v on --masteronly
		update_config="1"
	fi
fi

if [ "$update_config" -eq "1" ]; then
	echo "update cluster because of config changes"
	gpstop -u
fi

log

end_step $step
