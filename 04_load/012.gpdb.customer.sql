TRUNCATE table tpcds.customer;
INSERT INTO tpcds.customer SELECT * FROM ext_tpcds.customer;
