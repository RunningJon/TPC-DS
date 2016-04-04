CREATE EXTERNAL WEB TABLE reports.ddl
(id int, description varchar, tuples bigint, duration time) 
EXECUTE :EXECUTE ON MASTER
FORMAT 'TEXT' (DELIMITER '|');
