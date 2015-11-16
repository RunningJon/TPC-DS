select id, avg(extract('epoch' from duration)) as average_seconds
from testing.sql
group by id
order by 1;
