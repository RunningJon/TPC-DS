TRUNCATE table tpcds.web_returns;
INSERT INTO tpcds.web_returns SELECT * FROM ext_tpcds.web_returns;
