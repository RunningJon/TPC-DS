TRUNCATE table tpcds.web_page;
INSERT INTO tpcds.web_page SELECT * FROM ext_tpcds.web_page;
