CREATE EXTERNAL TABLE ext_tpcds.inventory (like tpcds.inventory)
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|' NULL AS '' ESCAPE AS E'\\');
