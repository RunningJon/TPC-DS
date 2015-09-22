CREATE EXTERNAL TABLE ext_tpcds.warehouse (like tpcds.warehouse)
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|' NULL AS '' ESCAPE AS E'\\');
