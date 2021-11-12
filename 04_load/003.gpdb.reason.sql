TRUNCATE table tpcds.reason;
INSERT INTO tpcds.reason SELECT * FROM ext_tpcds.reason;
