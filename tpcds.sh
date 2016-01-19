#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

GEN_DATA_SCALE=$1
if [ "$GEN_DATA_SCALE" == "" ]; then
	echo "You must provide the scale as a parameter in terms of Gigabytes."
	echo "Example: ./tpcds.sh 100"
	echo "This will create 100 GB of data for this test."
	exit 1
fi
QUIET=$2

MYCMD="tpcds.sh"
MYVAR="tpcds_variables.sh"
##################################################################################################################################################
# Functions
##################################################################################################################################################
check_variables()
{
	### Make sure variables file is available
	if [ ! -f "$PWD/$MYVAR" ]; then
		touch $PWD/$MYVAR
	fi
	local count=`grep "REPO=" $MYVAR | wc -l`
	if [ "$count" -eq "0" ]; then
		echo "REPO=\"TPC-DS\"" >> $MYVAR
	fi
	local count=`grep "REPO_URL=" $MYVAR | wc -l`
	if [ "$count" -eq "0" ]; then
		echo "REPO_URL=\"https://github.com/pivotalguru/TPC-DS\"" >> $MYVAR
	fi
	local count=`grep "ADMIN_USER=" $MYVAR | wc -l`
	if [ "$count" -eq "0" ]; then
		echo "ADMIN_USER=\"gpadmin\"" >> $MYVAR
	fi
	local count=`grep "INSTALL_DIR=" $MYVAR | wc -l`
	if [ "$count" -eq "0" ]; then
		echo "INSTALL_DIR=\"/pivotalguru\"" >> $MYVAR
	fi
	local count=`grep "EXPLAIN_ANALYZE=" $MYVAR | wc -l`
	if [ "$count" -eq "0" ]; then
		echo "EXPLAIN_ANALYZE=\"false\"" >> $MYVAR
	fi
	local count=`grep "E9=" $MYVAR | wc -l`
	if [ "$count" -eq "0" ]; then
		echo "E9=\"false\"" >> $MYVAR
	fi
	local count=`grep "RANDOM_DISTRIBUTION=" $MYVAR | wc -l`
	if [ "$count" -eq "0" ]; then
		echo "RANDOM_DISTRIBUTION=\"false\"" >> $MYVAR
	fi
	local count=`grep "MULTI_USER_TEST" $MYVAR | wc -l`
	if [ "$count" -eq "0" ]; then
		echo "MULTI_USER_TEST=\"true\"" >> $MYVAR
	fi
	local count=`grep "MULTI_USER_COUNT" $MYVAR | wc -l`
	if [ "$count" -eq "0" ]; then
		echo "MULTI_USER_COUNT=\"5\"" >> $MYVAR
	fi
	local count=`grep "TPCDS_VERSION" $MYVAR | wc -l`
	if [ "$count" -eq "0" ]; then
		echo "TPCDS_VERSION=\"1.4\"" >> $MYVAR
	fi

	echo "############################################################################"
	echo "Sourcing $MYVAR"
	echo "############################################################################"
	echo ""
	source $MYVAR
}

check_user()
{
	### Make sure root is executing the script. ###
	echo "############################################################################"
	echo "Make sure root is executing this script."
	echo "############################################################################"
	echo ""
	local WHOAMI=`whoami`
	if [ "$WHOAMI" != "root" ]; then
		echo "Script must be executed as root!"
		exit 1
	fi
}

yum_installs()
{
	### Install and Update Demos ###
	echo "############################################################################"
	echo "Install git and gcc with yum."
	echo "############################################################################"
	echo ""
	# Install git and gcc if not found
	local YUM_INSTALLED=$(yum --help 2> /dev/null | wc -l)
	local CURL_INSTALLED=$(gcc --help 2> /dev/null | wc -l)
	local GIT_INSTALLED=$(git --help 2> /dev/null | wc -l)

	if [ "$YUM_INSTALLED" -gt "0" ]; then
		if [ "$CURL_INSTALLED" -eq "0" ]; then
			yum -y install gcc
		fi
		if [ "$GIT_INSTALLED" -eq "0" ]; then
			yum -y install git
		fi
	else
		if [ "$CURL_INSTALLED" -eq "0" ]; then
			echo "gcc not installed and yum not found to install it."
			echo "Please install gcc and try again."
			exit 1
		fi
		if [ "$GIT_INSTALLED" -eq "0" ]; then
			echo "git not installed and yum not found to install it."
			echo "Please install git and try again."
			exit 1
		fi
	fi
	echo ""
}

repo_init()
{
	### Install repo ###
	echo "############################################################################"
	echo "Install the github repository."
	echo "############################################################################"
	echo ""

	internet_down="0"
	for j in $(curl google.com 2>&1 | grep "Could not resolve host"); do
		internet_down="1"
	done

	if [ ! -d $INSTALL_DIR ]; then
		if [ "$internet_down" -eq "1" ]; then
			echo "Unable to continue because repo hasn't been downloaded and Internet is not available."
			exit 1
		else
			echo ""
			echo "Creating install dir"
			echo "-------------------------------------------------------------------------"
			mkdir $INSTALL_DIR
			chown $ADMIN_USER $INSTALL_DIR
		fi
	fi

	if [ ! -d $INSTALL_DIR/$REPO ]; then
		if [ "$internet_down" -eq "1" ]; then
			echo "Unable to continue because repo hasn't been downloaded and Internet is not available."
			exit 1
		else
			echo ""
			echo "Creating $REPO directory"
			echo "-------------------------------------------------------------------------"
			mkdir $INSTALL_DIR/$REPO
			chown $ADMIN_USER $INSTALL_DIR/$REPO
			su -c "cd $INSTALL_DIR; GIT_SSL_NO_VERIFY=true; git clone --depth=1 $REPO_URL" $ADMIN_USER
		fi
	else
		if [ "$internet_down" -eq "0" ]; then
			git config --global user.email "$ADMIN_USER@$HOSTNAME"
			git config --global user.name "$ADMIN_USER"
			su -c "cd $INSTALL_DIR/$REPO; GIT_SSL_NO_VERIFY=true; git fetch --all; git reset --hard origin/master" $ADMIN_USER
		fi
	fi
}

script_check()
{
	### Make sure the repo doesn't have a newer version of this script. ###
	echo "############################################################################"
	echo "Make sure this script is up to date."
	echo "############################################################################"
	echo ""
	# Must be executed after the repo has been pulled
	local d=`diff $PWD/$MYCMD $INSTALL_DIR/$REPO/$MYCMD | wc -l`

	if [ "$d" -eq "0" ]; then
		echo "$MYCMD script is up to date so continuing to TPC-DS."
	else
		echo "$MYCMD script is NOT up to date."
		echo ""
		cp $INSTALL_DIR/$REPO/$MYCMD $PWD/$MYCMD
		echo "After this script completes, restart the $MYCMD with this command:"
		echo "./$MYCMD $GEN_DATA_SCALE $QUIET"
		exit 1
	fi

}

check_sudo()
{
	cp $INSTALL_DIR/$REPO/update_sudo.sh $PWD/update_sudo.sh
	$PWD/update_sudo.sh
}

##################################################################################################################################################
# Body
##################################################################################################################################################

check_user
check_variables
yum_installs
repo_init
script_check
check_sudo

if [[ "$E9" == "true" && "$TPCDS_VERSION" != "1.4" ]]; then
        echo "E9 scripts are only compatible with TPC-DS Version 1.4"
        exit 1
fi

su --session-command="cd \"$INSTALL_DIR/$REPO\"; ./rollout.sh $GEN_DATA_SCALE $EXPLAIN_ANALYZE $E9 $RANDOM_DISTRIBUTION $TPCDS_VERSION $QUIET" $ADMIN_USER

if [ "$MULTI_USER_TEST" == "true" ]; then
	su --session-command="cd \"$INSTALL_DIR/$REPO/testing\"; ./rollout.sh $GEN_DATA_SCALE $MULTI_USER_COUNT $E9" $ADMIN_USER 
fi
