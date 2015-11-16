select split_part(description, '.', 1) as session_id, sum(duration)::time
from testing.sql
group by split_part(description, '.', 1)
order by 1;
