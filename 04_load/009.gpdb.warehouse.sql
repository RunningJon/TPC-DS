TRUNCATE table tpcds.warehouse;
INSERT INTO tpcds.warehouse SELECT * FROM ext_tpcds.warehouse;
