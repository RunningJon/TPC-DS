CREATE EXTERNAL WEB TABLE reports.init
(id int, description varchar, duration time) 
EXECUTE :CMD ON MASTER 
FORMAT 'TEXT' (DELIMITER '|');
