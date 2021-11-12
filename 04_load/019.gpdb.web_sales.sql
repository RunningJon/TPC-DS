TRUNCATE table tpcds.web_sales;
INSERT INTO tpcds.web_sales SELECT * FROM ext_tpcds.web_sales;
