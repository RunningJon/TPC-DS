CREATE EXTERNAL TABLE reports.gen_data
(id int, description varchar, duration time) 
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|');
