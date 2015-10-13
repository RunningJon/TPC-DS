CREATE EXTERNAL TABLE ext_tpcds.web_page (like tpcds.web_page) 
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|' NULL AS '' ESCAPE AS E'\\');
