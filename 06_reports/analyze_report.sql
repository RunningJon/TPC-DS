SELECT split_part(description, '.', 2) as table_name, extract('epoch' from duration) AS seconds 
FROM reports.load 
WHERE tuples = 0
ORDER BY 1;
