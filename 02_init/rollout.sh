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

set_segment_bashrc()
{
	echo "if [ -f /etc/bashrc ]; then" > $PWD/segment_bashrc
	echo "	. /etc/bashrc" >> $PWD/segment_bashrc
	echo "fi" >> $PWD/segment_bashrc
	echo "source $GREENPLUM_PATH" >> $PWD/segment_bashrc
	echo "export LD_PRELOAD=/lib64/libz.so.1 ps" >> $PWD/segment_bashrc
	chmod 755 $PWD/segment_bashrc

	#copy generate_data.sh to ~/
	for i in $(cat $PWD/../segment_hosts.txt); do
		# don't overwrite the master.  Only needed on single node installs
		shortname=$(echo $i | awk -F '.' '{print $1}')
		if [ "$MASTER_HOST" != "$shortname" ]; then
			echo "copy new .bashrc to $i:$ADMIN_HOME"
			scp $PWD/segment_bashrc $i:$ADMIN_HOME/.bashrc
		fi
	done
}

check_gucs()
{
	update_config="0"

	get_version
	if [[ "$VERSION" == "gpdb_4_3" || "$VERSION" == "gpdb_5" || "$VERSION" == "hawq_1" ]]; then
		echo "check optimizer"
		counter=$(psql -v ON_ERROR_STOP=ON -t -A -c "show optimizer" | grep -i "on" | wc -l; exit ${PIPESTATUS[0]})

		if [ "$counter" -eq "0" ]; then
			echo "enabling optimizer"
			if [ "$VERSION" == "hawq_2" ]; then
				hawq config -c optimizer -v on
			else
				gpconfig -c optimizer -v on --masteronly
			fi
			update_config="1"
		fi

		echo "check analyze_root_partition"
		counter=$(psql -v ON_ERROR_STOP=ON -t -A -c "show optimizer_analyze_root_partition" | grep -i "on" | wc -l; exit ${PIPESTATUS[0]})
		if [ "$counter" -eq "0" ]; then
			echo "enabling analyze_root_partition"
			if [ "$VERSION" == "hawq_2" ]; then
				hawq config -c analyze_root_partition -v on
			else
				gpconfig -c optimizer_analyze_root_partition -v on --masteronly
			fi
			update_config="1"
		fi
	
		if [ "$VERSION" == "gpdb_5" ]; then
			counter=$(psql -v ON_ERROR_STOP=ON -t -A -c "show optimizer_join_arity_for_associativity_commutativity" | grep -i "2147483647" | wc -l; exit ${PIPESTATUS[0]})
			if [ "$counter" -eq "0" ]; then
				echo "setting optimizer_join_arity_for_associativity_commutativity"
				gpconfig -c optimizer_join_arity_for_associativity_commutativity -v 2147483647 --skipvalidation
				update_config="1"
			fi
		fi
	fi

	echo "check gp_autostats_mode"
	counter=$(psql -v ON_ERROR_STOP=ON -t -A -c "show gp_autostats_mode" | grep -i "none" | wc -l; exit ${PIPESTATUS[0]})
	if [ "$counter" -eq "0" ]; then
		echo "changing gp_autostats_mode to none"
		if [ "$VERSION" == "hawq_2" ]; then
			hawq config -c gp_autostats_mode -v NONE
		else
			gpconfig -c gp_autostats_mode -v none --masteronly
		fi
		update_config="1"
	fi

	echo "check default_statistics_target"
	counter=$(psql -v ON_ERROR_STOP=ON -t -A -c "show default_statistics_target" | grep "100" | wc -l; exit ${PIPESTATUS[0]})
	if [ "$counter" -eq "0" ]; then
		echo "changing default_statistics_target to 100"
		if [ "$VERSION" == "hawq_2" ]; then
			hawq config -c default_statistics_target -v 100
		else
			gpconfig -c default_statistics_target -v 100
		fi
		update_config="1"
	fi

	if [ "$update_config" -eq "1" ]; then
		echo "update cluster because of config changes"
		if [ "$VERSION" == "hawq_2" ]; then
			hawq stop cluster -u -a
		else
			gpstop -u
		fi
	fi
}

copy_config()
{
	echo "copy config files"
	if [ "$MASTER_DATA_DIRECTORY" != "" ]; then
		cp $MASTER_DATA_DIRECTORY/pg_hba.conf $PWD/../log/
		cp $MASTER_DATA_DIRECTORY/postgresql.conf $PWD/../log/
	fi
	#gp_segment_configuration
	psql -q -A -t -v ON_ERROR_STOP=ON -c "SELECT * FROM gp_segment_configuration" -o $PWD/../log/gp_segment_configuration.txt
}

set_psqlrc()
{
	echo "set search_path=tpcds,public;" > ~/.psqlrc
	echo "\timing" >> ~/.psqlrc
	chmod 600 ~/.psqlrc
}

set_segment_bashrc
check_gucs
copy_config
set_psqlrc

log

end_step $step
