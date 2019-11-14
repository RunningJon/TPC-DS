select n.nspname, c.relname
from pg_class c 
join pg_namespace n on c.relnamespace = n.oid 
join pg_partitions p on p.schemaname = n.nspname and p.tablename = c.relname 
where n.nspname = 'tpcds'
and p.partitionrank is null
and c.reltuples = 0
order by 1, 2;
