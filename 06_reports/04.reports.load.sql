CREATE EXTERNAL WEB TABLE reports.load
(id int, description varchar, tuples bigint, duration time) 
EXECUTE :EXECUTE ON MASTER
FORMAT 'TEXT' (DELIMITER '|');

