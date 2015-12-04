SELECT action, description, tuples, extract('epoch' from duration) AS seconds
FROM    (
	SELECT 0 AS dir, 'COMPILE_TPCDS' AS action, id, description, 0 AS tuples, duration FROM reports.compile_tpcds
	UNION
	SELECT 1 AS dir, 'GEN_DATA' AS action, id, description, 0 AS tuples, duration FROM reports.gen_data
	UNION
	SELECT 2 AS dir, 'INIT' AS action, id, description, 0 AS tuples, duration FROM reports.init
	UNION
	SELECT 3 AS dir, 'DDL' AS action, id, description, 0 AS tuples, duration FROM reports.ddl
	UNION
	SELECT 4 AS dir, 'LOAD' AS action, id, description, tuples, duration FROM reports.load 
	UNION
	SELECT 5 AS dir, 'SQL' AS action, id, split_part(description, '.', 2),  tuples, duration FROM reports.sql
	) AS sub
ORDER BY sub.dir, sub.description;
