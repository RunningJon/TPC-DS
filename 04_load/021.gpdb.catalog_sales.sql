TRUNCATE table tpcds.catalog_sales;
INSERT INTO tpcds.catalog_sales SELECT * FROM ext_tpcds.catalog_sales;
