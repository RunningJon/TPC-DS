CREATE TABLE tpcds.customer (
    c_customer_sk integer NOT NULL,
    c_customer_id character varying(16) NOT NULL,
    c_current_cdemo_sk integer,
    c_current_hdemo_sk integer,
    c_current_addr_sk integer,
    c_first_shipto_date_sk integer,
    c_first_sales_date_sk integer,
    c_salutation character varying(10),
    c_first_name character varying(20),
    c_last_name character varying(30),
    c_preferred_cust_flag character(1),
    c_birth_day integer,
    c_birth_month integer,
    c_birth_year integer,
    c_birth_country character varying(20),
    c_login character varying(13),
    c_email_address character varying(50),
    c_last_review_date integer
)
WITH (:SMALL_STORAGE)
:DISTRIBUTED_BY;
