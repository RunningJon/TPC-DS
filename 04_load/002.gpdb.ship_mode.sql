TRUNCATE table tpcds.ship_mode;
INSERT INTO tpcds.ship_mode SELECT * FROM ext_tpcds.ship_mode;
