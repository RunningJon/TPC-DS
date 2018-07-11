CREATE TABLE tpds_reports.ddl
(id int, description varchar, tuples bigint, duration time) 
DISTRIBUTED BY (id);
