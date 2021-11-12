TRUNCATE table tpcds.date_dim;
INSERT INTO tpcds.date_dim SELECT * FROM ext_tpcds.date_dim;
