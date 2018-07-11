SELECT split_part(description, '.', 2) as table_name, sum(tuples) as tuples, sum(extract('epoch' from duration)) AS seconds 
FROM tpcds_reports.load 
WHERE tuples > 0 
GROUP BY split_part(description, '.', 2)
ORDER BY 1;
