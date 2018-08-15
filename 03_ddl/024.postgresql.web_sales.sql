CREATE TABLE tpcds.web_sales (
    ws_sold_date_sk integer,
    ws_sold_time_sk integer,
    ws_ship_date_sk integer,
    ws_item_sk integer NOT NULL,
    ws_bill_customer_sk integer,
    ws_bill_cdemo_sk integer,
    ws_bill_hdemo_sk integer,
    ws_bill_addr_sk integer,
    ws_ship_customer_sk integer,
    ws_ship_cdemo_sk integer,
    ws_ship_hdemo_sk integer,
    ws_ship_addr_sk integer,
    ws_web_page_sk integer,
    ws_web_site_sk integer,
    ws_ship_mode_sk integer,
    ws_warehouse_sk integer,
    ws_promo_sk integer,
    ws_order_number integer NOT NULL,
    ws_quantity integer,
    ws_wholesale_cost numeric(7,2),
    ws_list_price numeric(7,2),
    ws_sales_price numeric(7,2),
    ws_ext_discount_amt numeric(7,2),
    ws_ext_sales_price numeric(7,2),
    ws_ext_wholesale_cost numeric(7,2),
    ws_ext_list_price numeric(7,2),
    ws_ext_tax numeric(7,2),
    ws_coupon_amt numeric(7,2),
    ws_ext_ship_cost numeric(7,2),
    ws_net_paid numeric(7,2),
    ws_net_paid_inc_tax numeric(7,2),
    ws_net_paid_inc_ship numeric(7,2),
    ws_net_paid_inc_ship_tax numeric(7,2),
    ws_net_profit numeric(7,2)
)
partition by range (ws_sold_date_sk);

CREATE TABLE tpcds.web_sales_2450815 PARTITION OF tpcds.web_sales FOR VALUES FROM (2450815) TO (2450855);
CREATE TABLE tpcds.web_sales_2450855 PARTITION OF tpcds.web_sales FOR VALUES FROM (2450855) TO (2450895);
CREATE TABLE tpcds.web_sales_2450895 PARTITION OF tpcds.web_sales FOR VALUES FROM (2450895) TO (2450935);
CREATE TABLE tpcds.web_sales_2450935 PARTITION OF tpcds.web_sales FOR VALUES FROM (2450935) TO (2450975);
CREATE TABLE tpcds.web_sales_2450975 PARTITION OF tpcds.web_sales FOR VALUES FROM (2450975) TO (2451015);
CREATE TABLE tpcds.web_sales_2451015 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451015) TO (2451055);
CREATE TABLE tpcds.web_sales_2451055 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451055) TO (2451095);
CREATE TABLE tpcds.web_sales_2451095 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451095) TO (2451135);
CREATE TABLE tpcds.web_sales_2451135 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451135) TO (2451175);
CREATE TABLE tpcds.web_sales_2451175 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451175) TO (2451215);
CREATE TABLE tpcds.web_sales_2451215 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451215) TO (2451255);
CREATE TABLE tpcds.web_sales_2451255 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451255) TO (2451295);
CREATE TABLE tpcds.web_sales_2451295 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451295) TO (2451335);
CREATE TABLE tpcds.web_sales_2451335 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451335) TO (2451375);
CREATE TABLE tpcds.web_sales_2451375 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451375) TO (2451415);
CREATE TABLE tpcds.web_sales_2451415 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451415) TO (2451455);
CREATE TABLE tpcds.web_sales_2451455 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451455) TO (2451495);
CREATE TABLE tpcds.web_sales_2451495 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451495) TO (2451535);
CREATE TABLE tpcds.web_sales_2451535 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451535) TO (2451575);
CREATE TABLE tpcds.web_sales_2451575 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451575) TO (2451615);
CREATE TABLE tpcds.web_sales_2451615 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451615) TO (2451655);
CREATE TABLE tpcds.web_sales_2451655 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451655) TO (2451695);
CREATE TABLE tpcds.web_sales_2451695 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451695) TO (2451735);
CREATE TABLE tpcds.web_sales_2451735 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451735) TO (2451775);
CREATE TABLE tpcds.web_sales_2451775 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451775) TO (2451815);
CREATE TABLE tpcds.web_sales_2451815 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451815) TO (2451855);
CREATE TABLE tpcds.web_sales_2451855 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451855) TO (2451895);
CREATE TABLE tpcds.web_sales_2451895 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451895) TO (2451935);
CREATE TABLE tpcds.web_sales_2451935 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451935) TO (2451975);
CREATE TABLE tpcds.web_sales_2451975 PARTITION OF tpcds.web_sales FOR VALUES FROM (2451975) TO (2452015);
CREATE TABLE tpcds.web_sales_2452015 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452015) TO (2452055);
CREATE TABLE tpcds.web_sales_2452055 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452055) TO (2452095);
CREATE TABLE tpcds.web_sales_2452095 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452095) TO (2452135);
CREATE TABLE tpcds.web_sales_2452135 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452135) TO (2452175);
CREATE TABLE tpcds.web_sales_2452175 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452175) TO (2452215);
CREATE TABLE tpcds.web_sales_2452215 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452215) TO (2452255);
CREATE TABLE tpcds.web_sales_2452255 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452255) TO (2452295);
CREATE TABLE tpcds.web_sales_2452295 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452295) TO (2452335);
CREATE TABLE tpcds.web_sales_2452335 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452335) TO (2452375);
CREATE TABLE tpcds.web_sales_2452375 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452375) TO (2452415);
CREATE TABLE tpcds.web_sales_2452415 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452415) TO (2452455);
CREATE TABLE tpcds.web_sales_2452455 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452455) TO (2452495);
CREATE TABLE tpcds.web_sales_2452495 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452495) TO (2452535);
CREATE TABLE tpcds.web_sales_2452535 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452535) TO (2452575);
CREATE TABLE tpcds.web_sales_2452575 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452575) TO (2452615);
CREATE TABLE tpcds.web_sales_2452615 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452615) TO (2452655);
CREATE TABLE tpcds.web_sales_2452655 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452655) TO (2452695);
CREATE TABLE tpcds.web_sales_2452695 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452695) TO (2452735);
CREATE TABLE tpcds.web_sales_2452735 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452735) TO (2452775);
CREATE TABLE tpcds.web_sales_2452775 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452775) TO (2452815);
CREATE TABLE tpcds.web_sales_2452815 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452815) TO (2452855);
CREATE TABLE tpcds.web_sales_2452855 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452855) TO (2452895);
CREATE TABLE tpcds.web_sales_2452895 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452895) TO (2452935);
CREATE TABLE tpcds.web_sales_2452935 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452935) TO (2452975);
CREATE TABLE tpcds.web_sales_2452975 PARTITION OF tpcds.web_sales FOR VALUES FROM (2452975) TO (2453015);

CREATE INDEX ON tpcds.web_sales_2450815 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2450855 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2450895 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2450935 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2450975 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451015 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451055 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451095 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451135 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451175 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451215 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451255 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451295 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451335 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451375 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451415 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451455 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451495 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451535 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451575 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451615 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451655 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451695 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451735 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451775 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451815 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451855 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451895 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451935 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2451975 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452015 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452055 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452095 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452135 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452175 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452215 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452255 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452295 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452335 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452375 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452415 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452455 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452495 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452535 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452575 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452615 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452655 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452695 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452735 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452775 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452815 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452855 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452895 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452935 (ws_sold_date_sk);
CREATE INDEX ON tpcds.web_sales_2452975 (ws_sold_date_sk);

--alter table tpcds.web_sales add primary key (ws_item_sk, ws_order_number);
