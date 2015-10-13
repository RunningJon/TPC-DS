CREATE EXTERNAL TABLE ext_tpcds.income_band (like tpcds.income_band)
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|' NULL AS '' ESCAPE AS E'\\');
