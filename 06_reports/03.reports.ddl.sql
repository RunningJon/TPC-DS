CREATE EXTERNAL TABLE reports.ddl
(id int, description varchar, duration time) 
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|');
