CREATE TABLE tpcds.web_page (
    wp_web_page_sk integer NOT NULL,
    wp_web_page_id character varying(16) NOT NULL,
    wp_rec_start_date date,
    wp_rec_end_date date,
    wp_creation_date_sk integer,
    wp_access_date_sk integer,
    wp_autogen_flag character(1),
    wp_customer_sk integer,
    wp_url character varying(100),
    wp_type character varying(50),
    wp_char_count integer,
    wp_link_count integer,
    wp_image_count integer,
    wp_max_ad_count integer
)
WITH (:SMALL_STORAGE)
:DISTRIBUTED_BY;
