CREATE EXTERNAL TABLE ext_tpcds.customer_address (like tpcds.customer_address)  
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|' NULL AS '' ESCAPE AS E'\\');
