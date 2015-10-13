TPC-DS benchmark scripts for HAWQ and Greenplum database.

1.  Download this repo.

2.  Start Pivotal HAWQ or Greenplum Database.

3.  Edit the variables.sh to modify the MASTER_HOST and GEN_DATA_SCALE variables.

4.  Ensure connectivity is possible to the MASTER_HOST.

5.  Ensure connectivity is possible from the Data Nodes / Segment Hosts to the host you installed this repo.

6.  Execute "./rollout.sh" to run the TPC-DS benchmark.

Note: Additional storage options are in functions.sh.
