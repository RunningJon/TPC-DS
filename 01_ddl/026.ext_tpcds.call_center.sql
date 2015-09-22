CREATE EXTERNAL TABLE ext_tpcds.call_center (like tpcds.call_center)
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|' NULL AS '' ESCAPE AS E'\\');
