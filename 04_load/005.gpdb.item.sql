TRUNCATE table tpcds.item;
INSERT INTO tpcds.item SELECT * FROM ext_tpcds.item;
