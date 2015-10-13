CREATE EXTERNAL WEB TABLE reports.gen_data
(id int, description varchar, duration time) 
EXECUTE :CMD ON MASTER 
FORMAT 'TEXT' (DELIMITER '|');
