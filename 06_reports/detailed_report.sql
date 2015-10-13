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
        SELECT 4 AS dir, 'LOAD' AS action, t1.id, t1.description, CASE WHEN c.relstorage <> 'x' THEN c.reltuples::int ELSE 0 END AS tuples, t1.duration
        FROM reports.load t1
        JOIN pg_class c ON split_part(t1.description, '.', 2) = c.relname
        JOIN pg_namespace n ON c.relnamespace = n.oid
        WHERE n.nspname = 'tpcds'
        UNION
        SELECT 5 AS dir, 'SQL' AS action, id, description, 0 AS tuples, duration FROM reports.sql
        ) AS sub
ORDER BY sub.dir;

