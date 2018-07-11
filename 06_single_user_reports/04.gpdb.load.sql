CREATE TABLE tpds_reports.load
(id int, description varchar, tuples bigint, duration time) 
DISTRIBUTED BY (id);
