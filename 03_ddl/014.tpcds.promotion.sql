CREATE TABLE tpcds.promotion (
    p_promo_sk integer NOT NULL,
    p_promo_id character varying(16) NOT NULL,
    p_start_date_sk integer,
    p_end_date_sk integer,
    p_item_sk integer,
    p_cost numeric(15,2),
    p_response_target integer,
    p_promo_name character varying(50),
    p_channel_dmail character(1),
    p_channel_email character(1),
    p_channel_catalog character(1),
    p_channel_tv character(1),
    p_channel_radio character(1),
    p_channel_press character(1),
    p_channel_event character(1),
    p_channel_demo character(1),
    p_channel_details character varying(100),
    p_purpose character varying(15),
    p_discount_active character(1)
)
WITH (:SMALL_STORAGE)
:DISTRIBUTED_BY;
