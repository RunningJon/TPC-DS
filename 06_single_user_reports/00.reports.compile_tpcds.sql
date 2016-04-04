DROP SCHEMA IF EXISTS reports CASCADE;
CREATE SCHEMA reports;

CREATE EXTERNAL WEB TABLE reports.compile_tpcds
(id int, description varchar, tuples bigint, duration time) 
EXECUTE :EXECUTE ON MASTER
FORMAT 'TEXT' (DELIMITER '|');
