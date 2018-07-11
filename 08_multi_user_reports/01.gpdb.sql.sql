CREATE TABLE tpcds_testing.sql
(id int, description varchar, tuples bigint, duration time)
DISTRIBUTED BY (id);
