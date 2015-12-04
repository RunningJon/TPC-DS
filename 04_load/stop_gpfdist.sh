#!/bin/bash
set -e

GPFDIST_PORT=8000

while read line; do
	GPFDIST_PORT=$(($GPFDIST_PORT + $GP_SEGMENT_ID))
	for i in $(ps -ef | grep gpfdist | grep $GPFDIST_PORT | grep -v grep | awk -F ' ' '{print $2}'); do 
		kill $i; 
	done
done < "${1:-/dev/stdin}"

