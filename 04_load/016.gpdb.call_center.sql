TRUNCATE table tpcds.call_center;
INSERT INTO tpcds.call_center SELECT * FROM ext_tpcds.call_center;
