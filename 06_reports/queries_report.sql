SELECT split_part(description, '.', 2) AS id,  tuples, extract('epoch' from duration) AS duration
FROM reports.sql
ORDER BY id;
