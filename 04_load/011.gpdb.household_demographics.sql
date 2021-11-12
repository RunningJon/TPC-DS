TRUNCATE table tpcds.household_demographics;
INSERT INTO tpcds.household_demographics SELECT * FROM ext_tpcds.household_demographics;
