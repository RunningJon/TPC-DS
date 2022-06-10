TRUNCATE table tpcds.store;
INSERT INTO tpcds.store SELECT * FROM ext_tpcds.store;
