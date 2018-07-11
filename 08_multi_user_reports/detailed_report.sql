select query_id, 
sum(session_1) as session_1,
sum(session_2) as session_2,
sum(session_3) as session_3,
sum(session_4) as session_4,
sum(session_5) as session_5,
sum(session_6) as session_6,
sum(session_7) as session_7,
sum(session_8) as session_8,
sum(session_9) as session_9,
sum(session_10) as session_10
from	(
	select split_part(description, '.', 2) as query_id, 
	case when split_part(description, '.', 1) = '1' then extract('epoch' from duration) else 0 end as session_1,
	case when split_part(description, '.', 1) = '2' then extract('epoch' from duration) else 0 end as session_2,
	case when split_part(description, '.', 1) = '3' then extract('epoch' from duration) else 0 end as session_3,
	case when split_part(description, '.', 1) = '4' then extract('epoch' from duration) else 0 end as session_4,
	case when split_part(description, '.', 1) = '5' then extract('epoch' from duration) else 0 end as session_5,
	case when split_part(description, '.', 1) = '6' then extract('epoch' from duration) else 0 end as session_6,
	case when split_part(description, '.', 1) = '7' then extract('epoch' from duration) else 0 end as session_7,
	case when split_part(description, '.', 1) = '8' then extract('epoch' from duration) else 0 end as session_8,
	case when split_part(description, '.', 1) = '9' then extract('epoch' from duration) else 0 end as session_9,
	case when split_part(description, '.', 1) = '10' then extract('epoch' from duration) else 0 end as session_10
	from tpcds_testing.sql
	) as sub
group by query_id
order by 1;
