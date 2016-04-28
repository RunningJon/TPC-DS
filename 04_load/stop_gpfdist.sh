#!/bin/bash
set -e
source /usr/local/greenplum-db-4.3.7.1/greenplum_path.sh

for i in $(ps -ef | grep gpfdist |  grep -v grep | grep -v stop_gpfdist | awk -F ' ' '{print $2}'); do
        echo "killing $i"
        kill $i
done
