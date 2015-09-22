CREATE EXTERNAL WEB TABLE reports.ddl
(id int, description varchar, duration time) 
EXECUTE :CMD ON MASTER 
FORMAT 'TEXT' (DELIMITER '|');
