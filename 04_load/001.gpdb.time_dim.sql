TRUNCATE table tpcds.time_dim;
INSERT INTO tpcds.time_dim SELECT * FROM ext_tpcds.time_dim;
