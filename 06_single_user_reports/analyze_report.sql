SELECT split_part(description, '.', 1) as schema_name, extract('epoch' from duration) AS seconds 
FROM tpcds_reports.load 
WHERE tuples = 0
ORDER BY 1;
