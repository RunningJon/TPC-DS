CREATE EXTERNAL WEB TABLE reports.gen_data
(id int, description varchar, tuples bigint, duration time) 
EXECUTE :EXECUTE ON MASTER
FORMAT 'TEXT' (DELIMITER '|');
