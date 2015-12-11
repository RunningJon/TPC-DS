########################################################################################
#TPC-DS benchmark scripts for HAWQ and Greenplum database.
#########################################################################################
#Multi-user testing script
#
#########################################################################################
#Notes
#########################################################################################
#
## Execute these scripts as user gpadmin.
#
## Execute 5, 10, 15, and 20 concurrent user testing in the background and log
## to run_all.log
nohup ./run_all.sh > run_all.log 2>&1 < run_all.log &
#
## Execute 5 concurrent user test in the foreground for a 3TB dataset
./rollout.sh 3000 5
#
## Check the status of the background processes running the TPC-DS queries
./check_status.sh
#
