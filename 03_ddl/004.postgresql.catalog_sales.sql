CREATE TABLE tpcds.catalog_sales (
    cs_sold_date_sk integer,
    cs_sold_time_sk integer,
    cs_ship_date_sk integer,
    cs_bill_customer_sk integer,
    cs_bill_cdemo_sk integer,
    cs_bill_hdemo_sk integer,
    cs_bill_addr_sk integer,
    cs_ship_customer_sk integer,
    cs_ship_cdemo_sk integer,
    cs_ship_hdemo_sk integer,
    cs_ship_addr_sk integer,
    cs_call_center_sk integer,
    cs_catalog_page_sk integer,
    cs_ship_mode_sk integer,
    cs_warehouse_sk integer,
    cs_item_sk integer NOT NULL,
    cs_promo_sk integer,
    cs_order_number bigint NOT NULL,
    cs_quantity integer,
    cs_wholesale_cost numeric(7,2),
    cs_list_price numeric(7,2),
    cs_sales_price numeric(7,2),
    cs_ext_discount_amt numeric(7,2),
    cs_ext_sales_price numeric(7,2),
    cs_ext_wholesale_cost numeric(7,2),
    cs_ext_list_price numeric(7,2),
    cs_ext_tax numeric(7,2),
    cs_coupon_amt numeric(7,2),
    cs_ext_ship_cost numeric(7,2),
    cs_net_paid numeric(7,2),
    cs_net_paid_inc_tax numeric(7,2),
    cs_net_paid_inc_ship numeric(7,2),
    cs_net_paid_inc_ship_tax numeric(7,2),
    cs_net_profit numeric(7,2)
)
partition by range(cs_sold_date_sk);

CREATE TABLE tpcds.catalog_sales_2450815 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2450815) TO (2450843);
CREATE TABLE tpcds.catalog_sales_2450843 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2450843) TO (2450871);
CREATE TABLE tpcds.catalog_sales_2450871 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2450871) TO (2450899);
CREATE TABLE tpcds.catalog_sales_2450899 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2450899) TO (2450927);
CREATE TABLE tpcds.catalog_sales_2450927 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2450927) TO (2450955);
CREATE TABLE tpcds.catalog_sales_2450955 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2450955) TO (2450983);
CREATE TABLE tpcds.catalog_sales_2450983 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2450983) TO (2451011);
CREATE TABLE tpcds.catalog_sales_2451011 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451011) TO (2451039);
CREATE TABLE tpcds.catalog_sales_2451039 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451039) TO (2451067);
CREATE TABLE tpcds.catalog_sales_2451067 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451067) TO (2451095);
CREATE TABLE tpcds.catalog_sales_2451095 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451095) TO (2451123);
CREATE TABLE tpcds.catalog_sales_2451123 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451123) TO (2451151);
CREATE TABLE tpcds.catalog_sales_2451151 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451151) TO (2451179);
CREATE TABLE tpcds.catalog_sales_2451179 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451179) TO (2451207);
CREATE TABLE tpcds.catalog_sales_2451207 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451207) TO (2451235);
CREATE TABLE tpcds.catalog_sales_2451235 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451235) TO (2451263);
CREATE TABLE tpcds.catalog_sales_2451263 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451263) TO (2451291);
CREATE TABLE tpcds.catalog_sales_2451291 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451291) TO (2451319);
CREATE TABLE tpcds.catalog_sales_2451319 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451319) TO (2451347);
CREATE TABLE tpcds.catalog_sales_2451347 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451347) TO (2451375);
CREATE TABLE tpcds.catalog_sales_2451375 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451375) TO (2451403);
CREATE TABLE tpcds.catalog_sales_2451403 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451403) TO (2451431);
CREATE TABLE tpcds.catalog_sales_2451431 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451431) TO (2451459);
CREATE TABLE tpcds.catalog_sales_2451459 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451459) TO (2451487);
CREATE TABLE tpcds.catalog_sales_2451487 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451487) TO (2451515);
CREATE TABLE tpcds.catalog_sales_2451515 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451515) TO (2451543);
CREATE TABLE tpcds.catalog_sales_2451543 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451543) TO (2451571);
CREATE TABLE tpcds.catalog_sales_2451571 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451571) TO (2451599);
CREATE TABLE tpcds.catalog_sales_2451599 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451599) TO (2451627);
CREATE TABLE tpcds.catalog_sales_2451627 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451627) TO (2451655);
CREATE TABLE tpcds.catalog_sales_2451655 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451655) TO (2451683);
CREATE TABLE tpcds.catalog_sales_2451683 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451683) TO (2451711);
CREATE TABLE tpcds.catalog_sales_2451711 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451711) TO (2451739);
CREATE TABLE tpcds.catalog_sales_2451739 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451739) TO (2451767);
CREATE TABLE tpcds.catalog_sales_2451767 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451767) TO (2451795);
CREATE TABLE tpcds.catalog_sales_2451795 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451795) TO (2451823);
CREATE TABLE tpcds.catalog_sales_2451823 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451823) TO (2451851);
CREATE TABLE tpcds.catalog_sales_2451851 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451851) TO (2451879);
CREATE TABLE tpcds.catalog_sales_2451879 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451879) TO (2451907);
CREATE TABLE tpcds.catalog_sales_2451907 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451907) TO (2451935);
CREATE TABLE tpcds.catalog_sales_2451935 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451935) TO (2451963);
CREATE TABLE tpcds.catalog_sales_2451963 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451963) TO (2451991);
CREATE TABLE tpcds.catalog_sales_2451991 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2451991) TO (2452019);
CREATE TABLE tpcds.catalog_sales_2452019 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452019) TO (2452047);
CREATE TABLE tpcds.catalog_sales_2452047 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452047) TO (2452075);
CREATE TABLE tpcds.catalog_sales_2452075 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452075) TO (2452103);
CREATE TABLE tpcds.catalog_sales_2452103 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452103) TO (2452131);
CREATE TABLE tpcds.catalog_sales_2452131 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452131) TO (2452159);
CREATE TABLE tpcds.catalog_sales_2452159 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452159) TO (2452187);
CREATE TABLE tpcds.catalog_sales_2452187 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452187) TO (2452215);
CREATE TABLE tpcds.catalog_sales_2452215 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452215) TO (2452243);
CREATE TABLE tpcds.catalog_sales_2452243 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452243) TO (2452271);
CREATE TABLE tpcds.catalog_sales_2452271 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452271) TO (2452299);
CREATE TABLE tpcds.catalog_sales_2452299 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452299) TO (2452327);
CREATE TABLE tpcds.catalog_sales_2452327 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452327) TO (2452355);
CREATE TABLE tpcds.catalog_sales_2452355 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452355) TO (2452383);
CREATE TABLE tpcds.catalog_sales_2452383 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452383) TO (2452411);
CREATE TABLE tpcds.catalog_sales_2452411 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452411) TO (2452439);
CREATE TABLE tpcds.catalog_sales_2452439 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452439) TO (2452467);
CREATE TABLE tpcds.catalog_sales_2452467 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452467) TO (2452495);
CREATE TABLE tpcds.catalog_sales_2452495 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452495) TO (2452523);
CREATE TABLE tpcds.catalog_sales_2452523 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452523) TO (2452551);
CREATE TABLE tpcds.catalog_sales_2452551 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452551) TO (2452579);
CREATE TABLE tpcds.catalog_sales_2452579 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452579) TO (2452607);
CREATE TABLE tpcds.catalog_sales_2452607 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452607) TO (2452635);
CREATE TABLE tpcds.catalog_sales_2452635 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452635) TO (2452663);
CREATE TABLE tpcds.catalog_sales_2452663 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452663) TO (2452691);
CREATE TABLE tpcds.catalog_sales_2452691 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452691) TO (2452719);
CREATE TABLE tpcds.catalog_sales_2452719 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452719) TO (2452747);
CREATE TABLE tpcds.catalog_sales_2452747 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452747) TO (2452775);
CREATE TABLE tpcds.catalog_sales_2452775 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452775) TO (2452803);
CREATE TABLE tpcds.catalog_sales_2452803 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452803) TO (2452831);
CREATE TABLE tpcds.catalog_sales_2452831 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452831) TO (2452859);
CREATE TABLE tpcds.catalog_sales_2452859 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452859) TO (2452887);
CREATE TABLE tpcds.catalog_sales_2452887 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452887) TO (2452915);
CREATE TABLE tpcds.catalog_sales_2452915 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452915) TO (2452943);
CREATE TABLE tpcds.catalog_sales_2452943 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452943) TO (2452971);
CREATE TABLE tpcds.catalog_sales_2452971 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452971) TO (2452999);
CREATE TABLE tpcds.catalog_sales_2452999 PARTITION OF tpcds.catalog_sales FOR VALUES FROM (2452999) TO (2453027);

CREATE INDEX ON tpcds.catalog_returns_2450815 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2450843 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2450871 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2450899 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2450927 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2450955 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2450983 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451011 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451039 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451067 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451095 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451123 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451151 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451179 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451207 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451235 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451263 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451291 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451319 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451347 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451375 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451403 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451431 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451459 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451487 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451515 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451543 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451571 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451599 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451627 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451655 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451683 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451711 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451739 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451767 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451795 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451823 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451851 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451879 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451907 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451935 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451963 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2451991 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452019 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452047 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452075 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452103 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452131 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452159 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452187 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452215 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452243 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452271 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452299 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452327 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452355 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452383 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452411 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452439 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452467 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452495 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452523 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452551 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452579 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452607 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452635 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452663 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452691 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452719 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452747 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452775 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452803 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452831 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452859 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452887 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452915 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452943 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452971 (cs_sold_date_sk);
CREATE INDEX ON tpcds.catalog_returns_2452999 (cs_sold_date_sk);

--alter table tpcds.catalog_sales add primary key (cs_item_sk, cs_order_number);
