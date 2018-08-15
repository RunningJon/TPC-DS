CREATE TABLE tpcds.inventory (
    inv_date_sk integer NOT NULL,
    inv_item_sk integer NOT NULL,
    inv_warehouse_sk integer NOT NULL,
    inv_quantity_on_hand integer
)
partition by range(inv_date_sk);


CREATE TABLE tpcds.inventory_2450815 PARTITION OF tpcds.inventory FOR VALUES FROM (2450815) TO (2450915);
CREATE TABLE tpcds.inventory_2450915 PARTITION OF tpcds.inventory FOR VALUES FROM (2450915) TO (2451015);
CREATE TABLE tpcds.inventory_2451015 PARTITION OF tpcds.inventory FOR VALUES FROM (2451015) TO (2451115);
CREATE TABLE tpcds.inventory_2451115 PARTITION OF tpcds.inventory FOR VALUES FROM (2451115) TO (2451215);
CREATE TABLE tpcds.inventory_2451215 PARTITION OF tpcds.inventory FOR VALUES FROM (2451215) TO (2451315);
CREATE TABLE tpcds.inventory_2451315 PARTITION OF tpcds.inventory FOR VALUES FROM (2451315) TO (2451415);
CREATE TABLE tpcds.inventory_2451415 PARTITION OF tpcds.inventory FOR VALUES FROM (2451415) TO (2451515);
CREATE TABLE tpcds.inventory_2451515 PARTITION OF tpcds.inventory FOR VALUES FROM (2451515) TO (2451615);
CREATE TABLE tpcds.inventory_2451615 PARTITION OF tpcds.inventory FOR VALUES FROM (2451615) TO (2451715);
CREATE TABLE tpcds.inventory_2451715 PARTITION OF tpcds.inventory FOR VALUES FROM (2451715) TO (2451815);
CREATE TABLE tpcds.inventory_2451815 PARTITION OF tpcds.inventory FOR VALUES FROM (2451815) TO (2451915);
CREATE TABLE tpcds.inventory_2451915 PARTITION OF tpcds.inventory FOR VALUES FROM (2451915) TO (2452015);
CREATE TABLE tpcds.inventory_2452015 PARTITION OF tpcds.inventory FOR VALUES FROM (2452015) TO (2452115);
CREATE TABLE tpcds.inventory_2452115 PARTITION OF tpcds.inventory FOR VALUES FROM (2452115) TO (2452215);
CREATE TABLE tpcds.inventory_2452215 PARTITION OF tpcds.inventory FOR VALUES FROM (2452215) TO (2452315);
CREATE TABLE tpcds.inventory_2452315 PARTITION OF tpcds.inventory FOR VALUES FROM (2452315) TO (2452415);
CREATE TABLE tpcds.inventory_2452415 PARTITION OF tpcds.inventory FOR VALUES FROM (2452415) TO (2452515);
CREATE TABLE tpcds.inventory_2452515 PARTITION OF tpcds.inventory FOR VALUES FROM (2452515) TO (2452615);
CREATE TABLE tpcds.inventory_2452615 PARTITION OF tpcds.inventory FOR VALUES FROM (2452615) TO (2452715);
CREATE TABLE tpcds.inventory_2452715 PARTITION OF tpcds.inventory FOR VALUES FROM (2452715) TO (2452815);
CREATE TABLE tpcds.inventory_2452815 PARTITION OF tpcds.inventory FOR VALUES FROM (2452815) TO (2452915);
CREATE TABLE tpcds.inventory_2452915 PARTITION OF tpcds.inventory FOR VALUES FROM (2452915) TO (2453015);

CREATE INDEX ON tpcds.inventory_2450815 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2450915 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2451015 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2451115 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2451215 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2451315 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2451415 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2451515 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2451615 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2451715 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2451815 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2451915 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2452015 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2452115 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2452215 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2452315 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2452415 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2452515 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2452615 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2452715 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2452815 (inv_date_sk);
CREATE INDEX ON tpcds.inventory_2452915 (inv_date_sk);

--alter table tpcds.inventory add primary key (inv_date_sk, inv_item_sk, inv_warehouse_sk);
