#!/bin/bash
set -e

for i in $(ps -ef | grep gpfdist |  grep -v grep | grep -v stop_gpfdist | awk -F ' ' '{print $2}'); do
        echo "killing $i"
        kill $i
done
