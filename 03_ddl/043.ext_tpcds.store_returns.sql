CREATE EXTERNAL TABLE ext_tpcds.store_returns (like tpcds.store_returns)
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|' NULL AS '' ESCAPE AS E'\\');
