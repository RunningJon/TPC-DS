select split_part(description, '.', 2) as query_id, avg(extract('epoch' from duration)) as average_seconds
from testing.sql
group by split_part(description, '.', 2)
order by 1;
