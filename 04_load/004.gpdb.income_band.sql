TRUNCATE table tpcds.income_band;
INSERT INTO tpcds.income_band SELECT * FROM ext_tpcds.income_band;
