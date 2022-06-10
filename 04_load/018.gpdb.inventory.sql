TRUNCATE table tpcds.inventory;
INSERT INTO tpcds.inventory SELECT * FROM ext_tpcds.inventory;
