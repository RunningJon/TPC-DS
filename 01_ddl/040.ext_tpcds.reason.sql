CREATE EXTERNAL TABLE ext_tpcds.reason (like tpcds.reason)
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|' NULL AS '' ESCAPE AS E'\\');
