CREATE EXTERNAL TABLE testing.sql
(id int, description varchar, duration time)
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|');
