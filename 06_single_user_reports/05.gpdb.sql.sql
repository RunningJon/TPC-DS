CREATE TABLE tpds_reports.sql
(id int, description varchar, tuples bigint, duration time) 
DISTRIBUTED BY (id);
