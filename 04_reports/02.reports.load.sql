CREATE EXTERNAL WEB TABLE reports.load
(id int, description varchar, duration time) 
EXECUTE :CMD ON MASTER  
FORMAT 'TEXT' (DELIMITER '|');

