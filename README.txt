########################################################################################
TPC-DS benchmark scripts for HAWQ and Greenplum database.
########################################################################################

########################################################################################
Prerequisites
########################################################################################
1. Greenplum Database or Apache HAWQ installed and running
2. Connectivity is possible to the MASTER_HOST and from the Data Nodes / Segment Hosts
3. Root access

########################################################################################
Installation
########################################################################################
1. ssh to the host that will be home to these scripts and files with root
ssh root@mdw

2. Download the tpcds.sh file
curl https://raw.githubusercontent.com/pivotalguru/TPC-DS/master/tpcds.sh > tpcds.sh
chmod 755 tpcds.sh

3. Execute tpcds.sh and specify the scale in Gigabtes and the number of threads that
will create the data
./tpcds.sh 100 8

This example will create a 100 GB TPC-DS dataset and run all of the queries.

Note: Increase the number of threads when building larger datasets and the host has 
available cores to process the data.

Aditionally, a quiet mode with no user prompts is available when an optional third 
parameter is provided with any value.  Example:
./tpcds.sh 100 8 shhh

########################################################################################
Notes
########################################################################################
- tpch_variables.sh file will be created with variables you can adjust
- The default location for the repo is /pivotalguru/TPC-DS but can be changed in the 
tpch_variables.sh file.
- Additional storage options are in /pivotalguru/TPC-DS/functions.sh
- Files for the benchmark will be created in /pivotalguru/TPC-DS/data[1-8]/
You can update these directories to be symbolic links to better utilize the disk 
volumes you have available.
- Example of running tpcds as root as a background process:
nohup ./tpcds.sh 3000 48 shh > tpcds.log 2>&1 < tpcds.log &
