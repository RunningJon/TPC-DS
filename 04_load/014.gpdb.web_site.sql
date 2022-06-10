TRUNCATE table tpcds.web_site;
INSERT INTO tpcds.web_site SELECT * FROM ext_tpcds.web_site;
