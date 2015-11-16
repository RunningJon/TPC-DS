#!/bin/bash

set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

clear

while [ "1" -ne "0" ]; do
	wc -l $PWD/../log/rollout_testing_*
	echo ""
	echo "Enter ctrl+c to exit..."
	sleep 5
	clear
done
