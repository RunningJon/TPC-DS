TRUNCATE table tpcds.store_returns;
INSERT INTO tpcds.store_returns SELECT * FROM ext_tpcds.store_returns;
