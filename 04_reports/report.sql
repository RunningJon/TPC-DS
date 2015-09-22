select 'DDL' as action, id, description, 0 as tuples, duration from reports.ddl
union
select 'LOAD' as action, t1.id, t1.description, CASE WHEN c.relstorage <> 'x' THEN c.reltuples::int ELSE 0 END AS tuples, t1.duration 
from reports.load t1
JOIN pg_class c on split_part(t1.description, '.', 2) = c.relname
JOIN pg_namespace n on c.relnamespace = n.oid
where n.nspname = 'tpcds'
union
select 'SQL' as action, id, description, 0 as tuples, duration from reports.sql
union
select 'TOTAL LOAD' as action, 1000, '' as description, 0 as tuples, sum(duration)::time
from reports.load
union
select 'AVG LOAD' as action, 1001, '' as description, 0 as tuples, avg(duration)::time
from reports.load
union
select 'TOTAL SQL' as action, 1002, '' as description, 0 as tuples, sum(duration)::time
from reports.sql
union
select 'AVG SQL' as action, 1003, '' as description, 0 as tuples, avg(duration)::time
from reports.sql
union
select 'TOTAL' as action, 1004, '' as description, 0 as tuples, sum(sub.duration)::time
from    (  
        select sum(duration)  as duration from reports.ddl
        union all
        select sum(duration)  as duration from reports.load
        union all
        select sum(duration)  as duration from reports.sql
        ) as sub
order by 2;
