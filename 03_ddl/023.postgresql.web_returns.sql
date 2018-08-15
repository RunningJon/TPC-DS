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
partition by (wr_returned_date_sk);

CREATE TABLE tpcds.web_returns_2450815 PARTITION OF tpcds.web_returns FOR VALUES FROM (2450815) TO (2450995);
CREATE TABLE tpcds.web_returns_2450995 PARTITION OF tpcds.web_returns FOR VALUES FROM (2450995) TO (2451175);
CREATE TABLE tpcds.web_returns_2451175 PARTITION OF tpcds.web_returns FOR VALUES FROM (2451175) TO (2451355);
CREATE TABLE tpcds.web_returns_2451355 PARTITION OF tpcds.web_returns FOR VALUES FROM (2451355) TO (2451535);
CREATE TABLE tpcds.web_returns_2451535 PARTITION OF tpcds.web_returns FOR VALUES FROM (2451535) TO (2451715);
CREATE TABLE tpcds.web_returns_2451715 PARTITION OF tpcds.web_returns FOR VALUES FROM (2451715) TO (2451895);
CREATE TABLE tpcds.web_returns_2451895 PARTITION OF tpcds.web_returns FOR VALUES FROM (2451895) TO (2452075);
CREATE TABLE tpcds.web_returns_2452075 PARTITION OF tpcds.web_returns FOR VALUES FROM (2452075) TO (2452255);
CREATE TABLE tpcds.web_returns_2452255 PARTITION OF tpcds.web_returns FOR VALUES FROM (2452255) TO (2452435);
CREATE TABLE tpcds.web_returns_2452435 PARTITION OF tpcds.web_returns FOR VALUES FROM (2452435) TO (2452615);
CREATE TABLE tpcds.web_returns_2452615 PARTITION OF tpcds.web_returns FOR VALUES FROM (2452615) TO (2452795);
CREATE TABLE tpcds.web_returns_2452795 PARTITION OF tpcds.web_returns FOR VALUES FROM (2452795) TO (2452975);
CREATE TABLE tpcds.web_returns_2452975 PARTITION OF tpcds.web_returns FOR VALUES FROM (2452975) TO (2453155);

CREATE INDEX ON tpcds.web_returns_2450815 (wr_returned_date_sk);
CREATE INDEX ON tpcds.web_returns_2450995 (wr_returned_date_sk);
CREATE INDEX ON tpcds.web_returns_2451175 (wr_returned_date_sk);
CREATE INDEX ON tpcds.web_returns_2451355 (wr_returned_date_sk);
CREATE INDEX ON tpcds.web_returns_2451535 (wr_returned_date_sk);
CREATE INDEX ON tpcds.web_returns_2451715 (wr_returned_date_sk);
CREATE INDEX ON tpcds.web_returns_2451895 (wr_returned_date_sk);
CREATE INDEX ON tpcds.web_returns_2452075 (wr_returned_date_sk);
CREATE INDEX ON tpcds.web_returns_2452255 (wr_returned_date_sk);
CREATE INDEX ON tpcds.web_returns_2452435 (wr_returned_date_sk);
CREATE INDEX ON tpcds.web_returns_2452615 (wr_returned_date_sk);
CREATE INDEX ON tpcds.web_returns_2452795 (wr_returned_date_sk);
CREATE INDEX ON tpcds.web_returns_2452975 (wr_returned_date_sk);

--alter table tpcds.web_returns add primary key (wr_order_number, wr_item_sk);
