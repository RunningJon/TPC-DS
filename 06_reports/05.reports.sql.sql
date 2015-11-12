CREATE EXTERNAL TABLE reports.sql
(id int, description varchar, duration time) 
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|');

