CREATE EXTERNAL TABLE ext_tpcds.date_dim (like tpcds.date_dim)
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|' NULL AS '' ESCAPE AS E'\\');
