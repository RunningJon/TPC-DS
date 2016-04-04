########################################################################################
#TPC-DS benchmark scripts for HAWQ and Greenplum database.
#########################################################################################
#Multi-user testing script
#
#########################################################################################
#Notes:
#Make sure the second parameter to rollout.sh matches the dataset size originally 
#created.  Also, the multi-user test must be done after the single user test has already
#completed.
#########################################################################################
#
## Execute these scripts as user gpadmin.
#
## Execute 5 user concurrent test in the background and log to rollout.log
./rollout.sh 3000 5 tpcds > rollout.log 2>&1 < rollout.log & 
#
## Check the status of the background processes running the TPC-DS queries
./check_status.sh
#
