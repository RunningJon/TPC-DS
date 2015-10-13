CREATE TABLE tpcds.store_sales (
    ss_sold_date_sk integer,
    ss_sold_time_sk integer,
    ss_item_sk integer NOT NULL,
    ss_customer_sk integer,
    ss_cdemo_sk integer,
    ss_hdemo_sk integer,
    ss_addr_sk integer,
    ss_store_sk integer,
    ss_promo_sk integer,
    ss_ticket_number integer NOT NULL,
    ss_quantity integer,
    ss_wholesale_cost numeric(7,2),
    ss_list_price numeric(7,2),
    ss_sales_price numeric(7,2),
    ss_ext_discount_amt numeric(7,2),
    ss_ext_sales_price numeric(7,2),
    ss_ext_wholesale_cost numeric(7,2),
    ss_ext_list_price numeric(7,2),
    ss_ext_tax numeric(7,2),
    ss_coupon_amt numeric(7,2),
    ss_net_paid numeric(7,2),
    ss_net_paid_inc_tax numeric(7,2),
    ss_net_profit numeric(7,2)
)
WITH (:LARGE_STORAGE)
DISTRIBUTED BY (ss_item_sk)
PARTITION BY RANGE (ss_sold_date_sk) 
(	PARTITION y_1998 START (2450816) END (2451180), 
	PARTITION y_1999 START (2451180) END (2451545), 
	PARTITION y_2000 START (2451545) END (2451911), 
	PARTITION y_2001 START (2451911) END (2452276), 
	PARTITION y_2002 START (2452276) END (2452641), 
	PARTITION y_2003 START (2452641) END (2452643), 
	DEFAULT PARTITION no_date_set
);
