CREATE EXTERNAL TABLE ext_tpcds.time_dim (like tpcds.time_dim) 
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|' NULL AS '' ESCAPE AS E'\\');
