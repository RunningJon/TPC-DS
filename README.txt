TPC-DS benchmark scripts for HAWQ and Greenplum database.

1.  Install git if needed 
sudo yum install git

2.  Clone the repo
git clone --depth=1 https://github.com/pivotalguru/TPC-DS

3.  Start Pivotal HAWQ or Greenplum Database.

4.  Edit the variables.sh to modify the MASTER_HOST and GEN_DATA_SCALE variables.

5.  Ensure connectivity is possible to the MASTER_HOST.

6.  Ensure connectivity is possible from the Data Nodes / Segment Hosts to the host you installed this repo.

7.  Execute "./rollout.sh" to run the TPC-DS benchmark.

Note: Additional storage options are in functions.sh.
