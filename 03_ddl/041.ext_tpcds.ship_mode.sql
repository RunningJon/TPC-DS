CREATE EXTERNAL TABLE ext_tpcds.ship_mode (like tpcds.ship_mode) 
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|' NULL AS '' ESCAPE AS E'\\');
