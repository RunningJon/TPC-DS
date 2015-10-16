#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

##################################################################################################################################################
# Functions
##################################################################################################################################################
check_variables()
{
	### Make sure variables file is available
	if [ ! -f "$PWD/variables.sh" ]; then
		touch $PWD/variables.sh
	fi
	local count=`grep "REPO=" variables.sh | wc -l`
	if [ "$count" -eq "0" ]; then
		echo "REPO=\"TPC-DS\"" >> variables.sh
	fi
	local count=`grep "REPO_URL=" variables.sh | wc -l`
	if [ "$count" -eq "0" ]; then
		echo "REPO_URL=\"https://github.com/pivotalguru/TPC-DS\"" >> variables.sh
	fi
	local count=`grep "ADMIN_USER=" variables.sh | wc -l`
	if [ "$count" -eq "0" ]; then
		echo "ADMIN_USER=\"gpadmin\"" >> variables.sh
	fi
	local count=`grep "INSTALL_DIR=" variables.sh | wc -l`
	if [ "$count" -eq "0" ]; then
		echo "INSTALL_DIR=\"pivotalguru\"" >> variables.sh
	fi

	echo "############################################################################"
	echo "Sourcing variables.sh"
	echo "############################################################################"
	echo ""
	source variables.sh
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
	local CURL_INSTALLED=`yum -C list installed gcc | grep gcc | wc -l`
	local GIT_INSTALLED=`yum -C list installed git | grep git | wc -l`

	if [ "$CURL_INSTALLED" -eq "0" ]; then
		yum -y install gcc
	else
		echo "gcc already installed"
	fi

	if [ "$GIT_INSTALLED" -eq "0" ]; then
		yum -y install git
	else
		echo "git already installed"
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
	if [ ! -d /$INSTALL_DIR ]; then
		echo ""
		echo "Creating install dir"
		echo "-------------------------------------------------------------------------"
		mkdir /$INSTALL_DIR
		chown $ADMIN_USER /$INSTALL_DIR
	fi

	if [ ! -d /$INSTALL_DIR/$REPO ]; then
		echo ""
		echo "Creating $REPO directory"
		echo "-------------------------------------------------------------------------"
		mkdir /$INSTALL_DIR/$REPO
		chown $ADMIN_USER /$INSTALL_DIR/$REPO
		su -c "cd /$INSTALL_DIR; git clone --depth=1 $REPO_URL" $ADMIN_USER
	else
		git config --global user.email "$ADMIN_USER@$HOSTNAME"
		git config --global user.name "$ADMIN_USER"
		su -c "cd /$INSTALL_DIR/$REPO; git fetch --all; git reset --hard origin/master" $ADMIN_USER
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
	local d=`diff $PWD/tpcds.sh /$INSTALL_DIR/$REPO/tpcds.sh | wc -l`

	if [ "$d" -eq "0" ]; then
		echo "tpcds.sh script is up to date so continuing to TPC-DS."
	else
		echo "tpcds.sh script is NOT up to date."
		echo ""
		cp /$INSTALL_DIR/$REPO/tpcds.sh $PWD/tpcds.sh
		echo "After this script completes, restart the tpcds.sh with this command:"
		echo "./tpcds.sh"
		exit 1
	fi

}

check_sudo()
{
	cp /$INSTALL_DIR/$REPO/update_sudo.sh $PWD/update_sudo.sh
	$PWD/update_sudo.sh
}

check_user
check_variables
yum_installs
repo_init
script_check
check_sudo
echo "done"
