TRUNCATE table tpcds.catalog_page;
INSERT INTO tpcds.catalog_page SELECT * FROM ext_tpcds.catalog_page;
