CREATE TABLE tpcds_reports.gen_data
(id int, description varchar, tuples bigint, duration time) 
DISTRIBUTED BY (id);
