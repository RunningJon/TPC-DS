CREATE EXTERNAL TABLE ext_tpcds.catalog_returns (like tpcds.catalog_returns)
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|' NULL AS '' ESCAPE AS E'\\');
