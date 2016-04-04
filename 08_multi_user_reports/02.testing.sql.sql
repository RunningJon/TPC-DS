CREATE EXTERNAL WEB TABLE testing.sql
(id int, description varchar, tuples bigint, duration time)
EXECUTE :EXECUTE ON MASTER
FORMAT 'TEXT' (DELIMITER '|');
