set client_encoding to 'latin1';

COPY tpcds.customer FROM :filename WITH DELIMITER '|' NULL '';
