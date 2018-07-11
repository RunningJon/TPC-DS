CREATE TABLE tpcds_reports.compile_tpcds
(id int, description varchar, tuples bigint, duration time) 
DISTRIBUTED BY (id);
