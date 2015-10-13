SELECT sub.action, extract('epoch' from sub.duration) AS seconds
FROM    (
	SELECT 'COMPILE_TPCDS' as action, 1000 AS order_by, sum(duration)::time AS duration
	FROM reports.compile_tpcds
	UNION ALL
	SELECT 'GEN_DATA' as action, 1001 AS order_by, sum(duration)::time AS duration
	FROM reports.gen_data
	UNION ALL
	SELECT 'INIT' as action, 1002 AS order_by, sum(duration)::time AS duration
	FROM reports.init
	UNION ALL
	SELECT 'DDL' as action, 1003 AS order_by, sum(duration)::time AS duration
	FROM reports.ddl
	UNION ALL
	SELECT 'LOAD' AS action, 1004 AS order_by, sum(duration)::time AS duration
	FROM reports.load
	UNION ALL
	SELECT 'SQL' as action, 1005 AS order_by, sum(duration)::time AS duration
	FROM reports.sql
	UNION ALL
	SELECT 'TOTAL' as action, 1006 AS order_by, sum(sub2.duration)::time AS duration
	from    (
		SELECT sum(duration) AS duration FROM reports.compile_tpcds
		UNION ALL
		SELECT sum(duration) AS duration FROM reports.gen_data
		UNION ALL
		SELECT sum(duration) AS duration FROM reports.init
		UNION ALL
		SELECT sum(duration) AS duration FROM reports.ddl
		UNION ALL
		SELECT sum(duration) AS duration FROM reports.load
		UNION ALL
		SELECT sum(duration) AS duration FROM reports.sql
		) as sub2
	) AS sub
ORDER BY order_by;
