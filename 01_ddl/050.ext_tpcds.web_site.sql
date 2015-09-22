CREATE EXTERNAL TABLE ext_tpcds.web_site (like tpcds.web_site)
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|' NULL AS '' ESCAPE AS E'\\');
