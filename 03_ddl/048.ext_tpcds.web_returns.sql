CREATE EXTERNAL TABLE ext_tpcds.web_returns (like tpcds.web_returns) 
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|' NULL AS '' ESCAPE AS E'\\');
