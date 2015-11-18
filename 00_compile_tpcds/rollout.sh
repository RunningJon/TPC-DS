#!/bin/bash
set -e

PWD=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
source $PWD/../functions.sh
source_bashrc

step=compile_tpcds
init_log $step
start_log
schema_name="tpcds"
table_name="compile"

cd $PWD/tools
rm -f *.o
make
cp tpcds.idx $PWD/../../
cp dsdgen $PWD/../../*_gen_data/
cp dsqgen $PWD/../../*_gen_data/
cd ../
rm -rf $PWD/../*_gen_data/query_templates
cp -R query_templates $PWD/../*_gen_data/
cd ../

log

end_step $step
