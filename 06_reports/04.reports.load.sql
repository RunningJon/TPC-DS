CREATE EXTERNAL TABLE reports.load
(id int, description varchar, duration time) 
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|');

