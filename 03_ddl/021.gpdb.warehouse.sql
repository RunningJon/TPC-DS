CREATE TABLE tpcds.warehouse (
    w_warehouse_sk integer NOT NULL,
    w_warehouse_id character varying(16) NOT NULL,
    w_warehouse_name character varying(20),
    w_warehouse_sq_ft integer,
    w_street_number character varying(10),
    w_street_name character varying(60),
    w_street_type character varying(15),
    w_suite_number character varying(10),
    w_city character varying(60),
    w_county character varying(30),
    w_state character varying(2),
    w_zip character varying(10),
    w_country character varying(20),
    w_gmt_offset numeric(5,2)
)
WITH (:SMALL_STORAGE)
:DISTRIBUTED_BY;
