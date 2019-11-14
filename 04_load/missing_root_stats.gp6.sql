select n.nspname, c.relname
from pg_class c 
join pg_namespace n on c.relnamespace = n.oid 
left outer join (select starelid from pg_statistic group by starelid) s on c.oid = s.starelid
join (select tablename from pg_partitions group by tablename) p on p.tablename = c.relname 
where n.nspname = 'tpcds' 
and s.starelid is null
order by 1, 2;
