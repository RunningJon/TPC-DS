CREATE EXTERNAL WEB TABLE reports.sql
(id int, description varchar, duration time) 
EXECUTE :CMD ON MASTER  
FORMAT 'TEXT' (DELIMITER '|');

