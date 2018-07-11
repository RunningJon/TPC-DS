########################################################################################
TPC-DS benchmark scripts for Greenplum database.
########################################################################################
Supported versions:
Greenplum 4.3, 5.*, 6.*
Open Source Greenplum 5.*, 6.*
Beta: PostgreSQL 10.*

########################################################################################
TPC-DS Information
########################################################################################
Version 2.x now uses TPC-DS version 2.1 for the standard queries.  

Version 2.2.x now supports Greenplum version 5.x.

########################################################################################
Query Options
########################################################################################
You can have the queries execute with "EXPLAIN ANALYZE" in order to see exactly the 
query plan used, the cost, the memory used, etc.  This is done in tpcds_variables.sh
like this:
EXPLAIN_ANALYZE="true"

########################################################################################
Storage Options
########################################################################################
Table storage is defined in functions.sh and is configured for optimal performance.

########################################################################################
Prerequisites
########################################################################################
1. Greenplum Database or PostgreSQL 10.x
2. Connectivity is possible to the MASTER_HOST and from the Data Nodes / Segment Hosts
3. Root access

########################################################################################
Installation
########################################################################################
1. ssh to the master host with root
ssh gpadmin@mdw; sudo bash

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
1. Execute tpcds.sh
nohup ./tpcds.sh > tpcds.log 2>&1 < tpcds.log &

########################################################################################
Notes
########################################################################################
- tpcds_variables.sh file will be created with variables you can adjust
- Files for the benchmark will be created in a sub-directory named pivotalguru located 
in each segment directory on each segment host / data node.
You can update these directories to be symbolic links to better utilize the disk 
volumes you have available.
- Example of running tpcds as root as a background process:

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

5.  Added "limit 100" to very large result set queries.  For the larger tests (e.g. 15TB), a few of the 
TPC-DS queries can output a very large number of rows which are just discarded.  
This was done on queries: 64, 34, and 71.

