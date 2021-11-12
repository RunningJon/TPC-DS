TRUNCATE table tpcds.customer_address;
INSERT INTO tpcds.customer_address SELECT * FROM ext_tpcds.customer_address;
