CREATE TABLE tpcds.item (
    i_item_sk integer NOT NULL,
    i_item_id character(16) NOT NULL,
    i_rec_start_date date,
    i_rec_end_date date,
    i_item_desc character varying(200),
    i_current_price numeric(7,2),
    i_wholesale_cost numeric(7,2),
    i_brand_id integer,
    i_brand character(50),
    i_class_id integer,
    i_class character(50),
    i_category_id integer,
    i_category character(50),
    i_manufact_id integer,
    i_manufact character(50),
    i_size character(20),
    i_formulation character(20),
    i_color character(20),
    i_units character(10),
    i_container character(10),
    i_manager_id integer,
    i_product_name character(50)
)
WITH (:SMALL_STORAGE)
:DISTRIBUTED_BY;
