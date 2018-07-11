CREATE TABLE tpcds.item (
    i_item_sk integer NOT NULL,
    i_item_id character varying(16) NOT NULL,
    i_rec_start_date date,
    i_rec_end_date date,
    i_item_desc character varying(200),
    i_current_price numeric(7,2),
    i_wholesale_cost numeric(7,2),
    i_brand_id integer,
    i_brand character varying(50),
    i_class_id integer,
    i_class character varying(50),
    i_category_id integer,
    i_category character varying(50),
    i_manufact_id integer,
    i_manufact character varying(50),
    i_size character varying(20),
    i_formulation character varying(20),
    i_color character varying(20),
    i_units character varying(10),
    i_container character varying(10),
    i_manager_id integer,
    i_product_name character varying(50)
)
WITH (:SMALL_STORAGE)
:DISTRIBUTED_BY;
