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
partition by range (sr_returned_date_sk);

CREATE TABLE tpcds.store_returns_2450815 PARTITION OF tpcds.store_returns FOR VALUES FROM (2450815) TO (2450915);
CREATE TABLE tpcds.store_returns_2450915 PARTITION OF tpcds.store_returns FOR VALUES FROM (2450915) TO (2451015);
CREATE TABLE tpcds.store_returns_2451015 PARTITION OF tpcds.store_returns FOR VALUES FROM (2451015) TO (2451115);
CREATE TABLE tpcds.store_returns_2451115 PARTITION OF tpcds.store_returns FOR VALUES FROM (2451115) TO (2451215);
CREATE TABLE tpcds.store_returns_2451215 PARTITION OF tpcds.store_returns FOR VALUES FROM (2451215) TO (2451315);
CREATE TABLE tpcds.store_returns_2451315 PARTITION OF tpcds.store_returns FOR VALUES FROM (2451315) TO (2451415);
CREATE TABLE tpcds.store_returns_2451415 PARTITION OF tpcds.store_returns FOR VALUES FROM (2451415) TO (2451515);
CREATE TABLE tpcds.store_returns_2451515 PARTITION OF tpcds.store_returns FOR VALUES FROM (2451515) TO (2451615);
CREATE TABLE tpcds.store_returns_2451615 PARTITION OF tpcds.store_returns FOR VALUES FROM (2451615) TO (2451715);
CREATE TABLE tpcds.store_returns_2451715 PARTITION OF tpcds.store_returns FOR VALUES FROM (2451715) TO (2451815);
CREATE TABLE tpcds.store_returns_2451815 PARTITION OF tpcds.store_returns FOR VALUES FROM (2451815) TO (2451915);
CREATE TABLE tpcds.store_returns_2451915 PARTITION OF tpcds.store_returns FOR VALUES FROM (2451915) TO (2452015);
CREATE TABLE tpcds.store_returns_2452015 PARTITION OF tpcds.store_returns FOR VALUES FROM (2452015) TO (2452115);
CREATE TABLE tpcds.store_returns_2452115 PARTITION OF tpcds.store_returns FOR VALUES FROM (2452115) TO (2452215);
CREATE TABLE tpcds.store_returns_2452215 PARTITION OF tpcds.store_returns FOR VALUES FROM (2452215) TO (2452315);
CREATE TABLE tpcds.store_returns_2452315 PARTITION OF tpcds.store_returns FOR VALUES FROM (2452315) TO (2452415);
CREATE TABLE tpcds.store_returns_2452415 PARTITION OF tpcds.store_returns FOR VALUES FROM (2452415) TO (2452515);
CREATE TABLE tpcds.store_returns_2452515 PARTITION OF tpcds.store_returns FOR VALUES FROM (2452515) TO (2452615);
CREATE TABLE tpcds.store_returns_2452615 PARTITION OF tpcds.store_returns FOR VALUES FROM (2452615) TO (2452715);
CREATE TABLE tpcds.store_returns_2452715 PARTITION OF tpcds.store_returns FOR VALUES FROM (2452715) TO (2452815);
CREATE TABLE tpcds.store_returns_2452815 PARTITION OF tpcds.store_returns FOR VALUES FROM (2452815) TO (2452915);
CREATE TABLE tpcds.store_returns_2452915 PARTITION OF tpcds.store_returns FOR VALUES FROM (2452915) TO (2453015);

CREATE INDEX ON tpcds.store_returns_2450815 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2450915 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2451015 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2451115 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2451215 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2451315 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2451415 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2451515 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2451615 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2451715 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2451815 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2451915 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2452015 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2452115 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2452215 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2452315 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2452415 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2452515 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2452615 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2452715 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2452815 (sr_returned_date_sk);
CREATE INDEX ON tpcds.store_returns_2452915 (sr_returned_date_sk);

--alter table tpcds.store_returns add primary key (sr_item_sk, sr_ticket_number);
