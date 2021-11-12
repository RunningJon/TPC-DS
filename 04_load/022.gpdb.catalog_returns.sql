TRUNCATE table tpcds.catalog_returns;
INSERT INTO tpcds.catalog_returns SELECT * FROM ext_tpcds.catalog_returns;
