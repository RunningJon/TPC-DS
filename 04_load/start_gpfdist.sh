#!/bin/bash
set -e
PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

GPFDIST_PORT=$1
GEN_DATA_PATH=$2

gpfdist -p $GPFDIST_PORT -d $GEN_DATA_PATH > gpfdist.$GPFDIST_PORT.log 2>&1 < gpfdist.$GPFDIST_PORT.log &
