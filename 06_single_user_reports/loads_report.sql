SELECT split_part(description, '.', 2) as table_name, tuples, extract('epoch' from duration) AS seconds 
FROM tpcds_reports.load 
WHERE tuples > 0 
ORDER BY 1;
