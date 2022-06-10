TRUNCATE table tpcds.promotion;
INSERT INTO tpcds.promotion SELECT * FROM ext_tpcds.promotion;
