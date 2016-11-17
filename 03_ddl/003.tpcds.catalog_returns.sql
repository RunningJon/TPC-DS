CREATE TABLE tpcds.catalog_returns (
    cr_returned_date_sk integer,
    cr_returned_time_sk integer,
    cr_item_sk integer NOT NULL,
    cr_refunded_customer_sk integer,
    cr_refunded_cdemo_sk integer,
    cr_refunded_hdemo_sk integer,
    cr_refunded_addr_sk integer,
    cr_returning_customer_sk integer,
    cr_returning_cdemo_sk integer,
    cr_returning_hdemo_sk integer,
    cr_returning_addr_sk integer,
    cr_call_center_sk integer,
    cr_catalog_page_sk integer,
    cr_ship_mode_sk integer,
    cr_warehouse_sk integer,
    cr_reason_sk integer,
    cr_order_number bigint NOT NULL,
    cr_return_quantity integer,
    cr_return_amount numeric(7,2),
    cr_return_tax numeric(7,2),
    cr_return_amt_inc_tax numeric(7,2),
    cr_fee numeric(7,2),
    cr_return_ship_cost numeric(7,2),
    cr_refunded_cash numeric(7,2),
    cr_reversed_charge numeric(7,2),
    cr_store_credit numeric(7,2),
    cr_net_loss numeric(7,2)
)
WITH (:MEDIUM_STORAGE)
:DISTRIBUTED_BY
partition by range(cr_returned_date_sk)
(start(2450815) INCLUSIVE end(2453005) INCLUSIVE every (8),
default partition others)
;
