CREATE TABLE tpcds.catalog_page (
    cp_catalog_page_sk integer NOT NULL,
    cp_catalog_page_id character varying(16) NOT NULL,
    cp_start_date_sk integer,
    cp_end_date_sk integer,
    cp_department character varying(50),
    cp_catalog_number integer,
    cp_catalog_page_number integer,
    cp_description character varying(100),
    cp_type character varying(100)
)
WITH (:SMALL_STORAGE)
:DISTRIBUTED_BY;
