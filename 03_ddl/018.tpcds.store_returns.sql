CREATE TABLE tpcds.store_returns (
    sr_returned_date_sk integer,
    sr_return_time_sk integer,
    sr_item_sk integer NOT NULL,
    sr_customer_sk integer,
    sr_cdemo_sk integer,
    sr_hdemo_sk integer,
    sr_addr_sk integer,
    sr_store_sk integer,
    sr_reason_sk integer,
    sr_ticket_number bigint NOT NULL,
    sr_return_quantity integer,
    sr_return_amt numeric(7,2),
    sr_return_tax numeric(7,2),
    sr_return_amt_inc_tax numeric(7,2),
    sr_fee numeric(7,2),
    sr_return_ship_cost numeric(7,2),
    sr_refunded_cash numeric(7,2),
    sr_reversed_charge numeric(7,2),
    sr_store_credit numeric(7,2),
    sr_net_loss numeric(7,2)
)
WITH (:MEDIUM_STORAGE)
:DISTRIBUTED_BY
partition by range(sr_returned_date_sk)
(start(2450815) INCLUSIVE end(2453005) INCLUSIVE every (100),
default partition others);
