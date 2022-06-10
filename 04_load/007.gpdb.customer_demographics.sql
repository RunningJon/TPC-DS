TRUNCATE table tpcds.customer_demographics;
INSERT INTO tpcds.customer_demographics SELECT * FROM ext_tpcds.customer_demographics;
