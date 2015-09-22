CREATE EXTERNAL TABLE ext_tpcds.promotion (like tpcds.promotion)
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|' NULL AS '' ESCAPE AS E'\\');
