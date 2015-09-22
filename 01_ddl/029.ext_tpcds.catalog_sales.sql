CREATE EXTERNAL TABLE ext_tpcds.catalog_sales (like tpcds.catalog_sales)
LOCATION (:LOCATION)
FORMAT 'TEXT' (DELIMITER '|' NULL AS '' ESCAPE AS E'\\');
