TRUNCATE table tpcds.store_sales;
INSERT INTO tpcds.store_sales SELECT * FROM ext_tpcds.store_sales;
