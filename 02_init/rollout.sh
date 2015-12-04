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

check_gucs()
{
	update_config="0"

	echo "check search_path"
	counter=$(psql -v ON_ERROR_STOP=1 -t -A -c "show search_path" | grep tpcds | wc -l)
	if [ "$counter" -eq "0" ]; then
		psql -v ON_ERROR_STOP=1 -c "ALTER USER gpadmin SET search_path=tpcds,public;"
	fi

	echo "check optimizer"
	counter=$(psql -v ON_ERROR_STOP=1 -t -A -c "show optimizer" | grep on | wc -l)
	if [ "$counter" -eq "0" ]; then
		echo "enabling optimizer"
		gpconfig -c optimizer -v on --masteronly
		update_config="1"
	fi

	echo "check analyze_root_partition"
	counter=$(psql -v ON_ERROR_STOP=1 -t -A -c "show optimizer_analyze_root_partition" | grep on | wc -l)
	if [ "$counter" -eq "0" ]; then
		echo "enabling analyze_root_partition"
		gpconfig -c optimizer_analyze_root_partition -v on --masteronly
		update_config="1"
	fi

	if [ "$update_config" -eq "1" ]; then
		echo "update cluster because of config changes"
		gpstop -u
	fi
}

copy_config()
{
	echo "copy config files"
	cp $MASTER_DATA_DIRECTORY/pg_hba.conf $PWD/../log/
	cp $MASTER_DATA_DIRECTORY/postgresql.conf $PWD/../log/
	#gp_segment_configuration
	psql -q -A -t -v ON_ERROR_STOP=1 -c "SELECT * FROM gp_segment_configuration ORDER BY dbid" -o $PWD/../log/gp_segment_configuration.txt
}

set_psqlrc()
{
	echo "make sure timing and any other option is not in the psqlrc file"
	echo "" > ~/.psqlrc
}

check_gucs
copy_config
set_psqlrc

log

end_step $step
