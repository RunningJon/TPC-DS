#!/bin/bash
set -e

logfile=$(eval echo ~/)
logfile+=test.log

i=0
GPFDIST_PORT=8000

while read line; do
	GPFDIST_PORT=$(($GPFDIST_PORT + $GP_SEGMENT_ID))
done < "${1:-/dev/stdin}"

DATA_DIRECTORY="$GP_SEG_DATADIR"/pivotalguru

echo "Starting gpfdist on port: $GPFDIST_PORT" >> $logfile

gpfdist -p $GPFDIST_PORT -d $DATA_DIRECTORY >> $DATA_DIRECTORY/gpfdist_"$GPFDIST_PORT".log 2>&1 < $DATA_DIRECTORY/gpfdist_"$GPFDIST_PORT".log & 
