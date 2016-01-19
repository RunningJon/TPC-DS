########################################################################################
TPC-DS benchmark scripts for HAWQ and Greenplum database.
########################################################################################

########################################################################################
TPC-DS Information
########################################################################################
Version 2.x now uses TPC-DS version 2.1 for the standard (E9=false) queries.  E9 version
is based on version 1.4 with static and modified query 67.

########################################################################################
Prerequisites
########################################################################################
1. Greenplum Database or Apache HAWQ installed and running
2. Connectivity is possible to the MASTER_HOST and from the Data Nodes / Segment Hosts
3. Root access

########################################################################################
Installation
########################################################################################
1. ssh to the master host with root
ssh root@mdw

2. Download the tpcds.sh file
curl https://raw.githubusercontent.com/pivotalguru/TPC-DS/master/tpcds.sh > tpcds.sh
chmod 755 tpcds.sh

########################################################################################
Variables and Configuration
########################################################################################
By default, the installation will create the scripts in /pivotalguru/TPC-DS on the 
Master host.  This can be changed by editing the dynamically configured 
tpcds_variables.sh file that is created the first time tpcds.sh is run.  

Also by default, TPC-DS files are generated on each Segment Host / Data Node in the 
Segement's PGDATA/pivotalguru directory.  If there isn't enough space in this directory
in each Segment, you can create a symbolic link to a drive location that does have 
enough space.

########################################################################################
Execution
########################################################################################
1. Execute tpcds.sh and specify the scale in Gigabtes 
./tpcds.sh 100 

This example will create a 100 GB TPC-DS dataset and run all of the queries.

A quiet mode with no user prompts is available when an optional second parameter is 
provided with any value.

Example:
./tpcds.sh 100 shhh

########################################################################################
Notes
########################################################################################
- tpch_variables.sh file will be created with variables you can adjust
- Files for the benchmark will be created in a sub-directory named pivotalguru located 
in each segment directory on each segment host / data node.
You can update these directories to be symbolic links to better utilize the disk 
volumes you have available.
- Example of running tpcds as root as a background process:
nohup ./tpcds.sh 3000 shh > tpcds.log 2>&1 < tpcds.log &

########################################################################################
TPC-DS Minor Modifications
########################################################################################
1.  Change to SQL queries that subtracted or added days were modified slightly:

Old:
and (cast('2000-02-28' as date) + 30 days)

New:
and (cast('2000-02-28' as date) + '30 days'::interval)

This was done on queries: 5, 12, 16, 20, 21, 32, 37, 40, 77, 80, 82, 92, 94, 95, and 98.

2.  Change to queries with ORDER BY on column alias to use sub-select.

Old: 
select  
    sum(ss_net_profit) as total_sum
   ,s_state
   ,s_county
   ,grouping(s_state)+grouping(s_county) as lochierarchy
   ,rank() over (
 	partition by grouping(s_state)+grouping(s_county),
 	case when grouping(s_county) = 0 then s_state end 
 	order by sum(ss_net_profit) desc) as rank_within_parent
 from
    store_sales
   ,date_dim       d1
   ,store
 where
    d1.d_month_seq between 1212 and 1212+11
 and d1.d_date_sk = ss_sold_date_sk
 and s_store_sk  = ss_store_sk
 and s_state in
             ( select s_state
               from  (select s_state as s_state,
 			    rank() over ( partition by s_state order by sum(ss_net_profit) desc) as ranking
                      from   store_sales, store, date_dim
                      where  d_month_seq between 1212 and 1212+11
 			    and d_date_sk = ss_sold_date_sk
 			    and s_store_sk  = ss_store_sk
                      group by s_state
                     ) tmp1 
               where ranking <= 5
             )
 group by rollup(s_state,s_county)
 order by
   lochierarchy desc
  ,case when lochierarchy = 0 then s_state end
  ,rank_within_parent
 limit 100;

New:
select * from ( --new
select  
    sum(ss_net_profit) as total_sum
   ,s_state
   ,s_county
   ,grouping(s_state)+grouping(s_county) as lochierarchy
   ,rank() over (
 	partition by grouping(s_state)+grouping(s_county),
 	case when grouping(s_county) = 0 then s_state end 
 	order by sum(ss_net_profit) desc) as rank_within_parent
 from
    store_sales
   ,date_dim       d1
   ,store
 where
    d1.d_month_seq between 1212 and 1212+11
 and d1.d_date_sk = ss_sold_date_sk
 and s_store_sk  = ss_store_sk
 and s_state in
             ( select s_state
               from  (select s_state as s_state,
 			    rank() over ( partition by s_state order by sum(ss_net_profit) desc) as ranking
                      from   store_sales, store, date_dim
                      where  d_month_seq between 1212 and 1212+11
 			    and d_date_sk = ss_sold_date_sk
 			    and s_store_sk  = ss_store_sk
                      group by s_state
                     ) tmp1 
               where ranking <= 5
             )
 group by rollup(s_state,s_county)
) AS sub --new
 order by
   lochierarchy desc
  ,case when lochierarchy = 0 then s_state end
  ,rank_within_parent
 limit 100;

This was done on queries: 36 and 70.

3. Query templates were modified to exclude columns not found in the query.  In these cases, the common 
table expression used aliased columns but the dynamic filters included both the alias name as well as the
original name.  Referencing the original column name instead of the alias causes the query parser to not
find the column. 

This was done on query 86.

4.  Added table aliases.
This was done on queries: 2, 14, and 23.

5.  Using approved query variant for query 67.
