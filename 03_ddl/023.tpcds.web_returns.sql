CREATE TABLE tpcds.web_returns (
    wr_returned_date_sk integer,
    wr_returned_time_sk integer,
    wr_item_sk integer NOT NULL,
    wr_refunded_customer_sk integer,
    wr_refunded_cdemo_sk integer,
    wr_refunded_hdemo_sk integer,
    wr_refunded_addr_sk integer,
    wr_returning_customer_sk integer,
    wr_returning_cdemo_sk integer,
    wr_returning_hdemo_sk integer,
    wr_returning_addr_sk integer,
    wr_web_page_sk integer,
    wr_reason_sk integer,
    wr_order_number integer NOT NULL,
    wr_return_quantity integer,
    wr_return_amt numeric(7,2),
    wr_return_tax numeric(7,2),
    wr_return_amt_inc_tax numeric(7,2),
    wr_fee numeric(7,2),
    wr_return_ship_cost numeric(7,2),
    wr_refunded_cash numeric(7,2),
    wr_reversed_charge numeric(7,2),
    wr_account_credit numeric(7,2),
    wr_net_loss numeric(7,2)
)
WITH (:SMALL_STORAGE)
:DISTRIBUTED_BY;
