DROP SCHEMA IF EXISTS reports CASCADE;
CREATE SCHEMA reports;

CREATE EXTERNAL TABLE reports.compile_tpcds
(id int, description varchar, duration time) 
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|');
