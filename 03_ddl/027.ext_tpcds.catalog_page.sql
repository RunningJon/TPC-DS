CREATE EXTERNAL TABLE ext_tpcds.catalog_page (like tpcds.catalog_page)
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|' NULL AS '' ESCAPE AS E'\\');
