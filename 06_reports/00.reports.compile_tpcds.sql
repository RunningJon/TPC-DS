DROP SCHEMA IF EXISTS reports CASCADE;
CREATE SCHEMA REPORTS;

CREATE EXTERNAL WEB TABLE reports.compile_tpcds
(id int, description varchar, duration time) 
EXECUTE :CMD ON MASTER 
FORMAT 'TEXT' (DELIMITER '|');
