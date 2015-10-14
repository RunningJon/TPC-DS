TPC-DS benchmark scripts for HAWQ and Greenplum database.

1. ssh to the host that will be home to these scripts and files with gpadmins
ssh gpadmin@mdw

2.  Yum installs
sudo yum install git
sudo yum install recode
sudo yum install gcc

3.  Clone the repo
git clone --depth=1 https://github.com/pivotalguru/TPC-DS

4.  Start Pivotal HAWQ or Greenplum Database.

5.  Edit the variables.sh to modify the MASTER_HOST and GEN_DATA_SCALE variables.

6.  Ensure connectivity is possible to the MASTER_HOST and from the Data Nodes / Segment Hosts to the host you installed this repo.

7.  Execute the TPC-DS benchmark.
cd TPC-DS/
./rollout.sh

Note: Additional storage options are in functions.sh.
