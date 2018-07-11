CREATE TABLE tpcds.customer_address (
    ca_address_sk integer NOT NULL,
    ca_address_id character varying(16) NOT NULL,
    ca_street_number character varying(10),
    ca_street_name character varying(60),
    ca_street_type character varying(15),
    ca_suite_number character varying(10),
    ca_city character varying(60),
    ca_county character varying(30),
    ca_state character varying(2),
    ca_zip character varying(10),
    ca_country character varying(20),
    ca_gmt_offset numeric(5,2),
    ca_location_type character varying(20)
)
WITH (:SMALL_STORAGE)
:DISTRIBUTED_BY;
