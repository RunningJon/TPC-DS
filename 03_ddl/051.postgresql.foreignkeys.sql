--store_sales
alter table store_sales add foreign key (ss_sold_date_sk) references date_dim (d_date_sk);
alter table store_sales add foreign key (ss_sold_time_sk) references time_dim (t_time_sk);
alter table store_sales add foreign key (ss_item_sk) references item (i_item_sk);
alter table store_sales add foreign key (ss_customer_sk) references customer (c_customer_sk);
alter table store_sales add foreign key (ss_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table store_sales add foreign key (ss_hdemo_sk) references household_demographics (hd_demo_sk);
alter table store_sales add foreign key (ss_addr_sk) references customer_address (ca_address_sk);
alter table store_sales add foreign key (ss_store_sk) references store (s_store_sk);
alter table store_sales add foreign key (ss_promo_sk) references promotion (p_promo_sk);

--store_returns
alter table store_returns add foreign key (sr_returned_date_sk) references date_dim (d_date_sk);
alter table store_returns add foreign key (sr_return_time_sk) references time_dim (t_time_sk);
alter table store_returns add foreign key (sr_item_sk) references item (i_item_sk);
alter table store_returns add foreign key (sr_item_sk, sr_ticket_number) references store_sales (ss_item_sk, ss_ticket_number);
alter table store_returns add foreign key (sr_customer_sk) references customer (c_customer_sk);
alter table store_returns add foreign key (sr_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table store_returns add foreign key (sr_hdemo_sk) references household_demographics (hd_demo_sk);
alter table store_returns add foreign key (sr_addr_sk) references customer_address (ca_address_sk);
alter table store_returns add foreign key (sr_store_sk) references store (s_store_sk);
alter table store_returns add foreign key (sr_reason_sk) references reason (r_reason_sk);

--catalog_sales
alter table catalog_sales add foreign key (cs_sold_date_sk) references date_dim (d_date_sk);
alter table catalog_sales add foreign key (cs_sold_time_sk) references time_dim (t_time_sk);
alter table catalog_sales add foreign key (cs_ship_date_sk) references date_dim (d_date_sk);
alter table catalog_sales add foreign key (cs_bill_customer_sk) references customer (c_customer_sk);
alter table catalog_sales add foreign key (cs_bill_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table catalog_sales add foreign key (cs_bill_hdemo_sk) references household_demographics (hd_demo_sk);
alter table catalog_sales add foreign key (cs_bill_addr_sk) references customer_address (ca_address_sk);
alter table catalog_sales add foreign key (cs_ship_customer_sk) references household_demographics (hd_demo_sk);
alter table catalog_sales add foreign key (cs_ship_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table catalog_sales add foreign key (cs_ship_hdemo_sk) references household_demographics (hd_demo_sk);
alter table catalog_sales add foreign key (cs_ship_addr_sk) references customer_address (ca_address_sk);
alter table catalog_sales add foreign key (cs_call_center_sk) references call_center (cc_call_center_sk);
alter table catalog_sales add foreign key (cs_catalog_page_sk) references catalog_page (cp_catalog_page_sk);
alter table catalog_sales add foreign key (cs_ship_mode_sk) references ship_mode (sm_ship_mode_sk);
alter table catalog_sales add foreign key (cs_warehouse_sk) references warehouse (w_warehouse_sk);
alter table catalog_sales add foreign key (cs_item_sk) references item (i_item_sk);
alter table catalog_sales add foreign key (cs_promo_sk) references promotion (p_promo_sk);

--catalog_returns
alter table catalog_returns add foreign key (cr_returned_date_sk) references date_dim (d_date_sk);
alter table catalog_returns add foreign key (cr_return_time_sk) references time_dim (t_time_sk);
alter table catalog_returns add foreign key (cr_item_sk) references item (i_item_sk);
alter table catalog_returns add foreign key (cr_item_sk, cr_order_number) references catalog_sales (cs_item_sk, cs_order_number);
alter table catalog_returns add foreign key (cr_refunded_customer_sk) references customer (c_customer_sk);
alter table catalog_returns add foreign key (cr_refunded_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table catalog_returns add foreign key (cr_refunded_hdemo_sk) references household_demographics (hd_demo_sk);
alter table catalog_returns add foreign key (cr_refunded_addr_sk) references customer_address (ca_address_sk);
alter table catalog_returns add foreign key (cr_returning_customer_sk) references customer (c_customer_sk);
alter table catalog_returns add foreign key (cr_returning_hdemo_sk) references household_demographics (hd_demo_sk);
alter table catalog_returns add foreign key (cr_returning_addr_sk) references customer_address (ca_address_sk);
alter table catalog_returns add foreign key (cr_call_center_sk) references call_center (cc_call_center_sk);
alter table catalog_returns add foreign key (cr_catalog_page_sk) references catalog_page (cp_catalog_page_sk);
alter table catalog_returns add foreign key (cr_ship_mode_sk) references ship_mode (sm_ship_mode_sk);
alter table catalog_returns add foreign key (cr_warehouse_sk) references warehouse (w_warehouse_sk);
alter table catalog_returns add foreign key (cr_reason_sk) references reason (r_reason_sk);

--web_sales
alter table web_sales add foreign key (ws_sold_date_sk) references date_dim (d_date_sk);
alter table web_sales add foreign key (ws_sold_time_sk) references time_dim (t_time_sk);
alter table web_sales add foreign key (ws_ship_date_sk) references date_dim (d_date_sk);
alter table web_sales add foreign key (ws_item_sk) references item (i_item_sk);
alter table web_sales add foreign key (ws_bill_customer_sk) references customer (c_customer_sk);
alter table web_sales add foreign key (ws_bill_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table web_sales add foreign key (ws_bill_hdemo_sk) references household_demographics (hd_demo_sk);
alter table web_sales add foreign key (ws_bill_addr_sk) references customer_address (ca_address_sk);
alter table web_sales add foreign key (ws_ship_customer_sk) references customer (c_customer_sk);
alter table web_sales add foreign key (ws_ship_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table web_sales add foreign key (ws_ship_hdemo_sk) references household_demographics (hd_demo_sk);
alter table web_sales add foreign key (ws_ship_addr_sk) references customer_address (ca_address_sk);
alter table web_sales add foreign key (ws_web_page_sk) references web_page (wp_web_page_sk);
alter table web_sales add foreign key (ws_web_site_sk) references web_site (web_site_sk);
alter table web_sales add foreign key (ws_ship_mode_sk) references ship_mode (sm_ship_mode_sk);
alter table web_sales add foreign key (ws_warehouse_sk) references warehouse (w_warehouse_sk);
alter table web_sales add foreign key (ws_promo_sk) references promotion (p_promo_sk);

--web_returns
alter table web_returns add foreign key (wr_returned_date_sk) references date_dim (d_date_sk);
alter table web_returns add foreign key (wr_returned_time_sk) references time_dim (t_time_sk);
alter table web_returns add foreign key (wr_item_sk) references item (i_item_sk);
alter table web_returns add foreign key (wr_item_sk, wr_order_number) references web_sales (ws_item_sk, ws_order_number);
alter table web_returns add foreign key (wr_refunded_customer_sk) references customer (c_customer_sk);
alter table web_returns add foreign key (wr_refunded_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table web_returns add foreign key (wr_refunded_hdemo_sk) references household_demographics (hd_demo_sk);
alter table web_returns add foreign key (wr_refunded_addr_sk) references customer_address (ca_address_sk);
alter table web_returns add foreign key (wr_returning_customer_sk) references customer (c_customer_sk);
alter table web_returns add foreign key (wr_returning_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table web_returns add foreign key (wr_returning_hdemo_sk) references household_demographics (hd_demo_sk);
alter table web_returns add foreign key (wr_returning_addr_sk) references customer_address (ca_address_sk);
alter table web_returns add foreign key (wr_web_page_sk) references web_page (wp_web_page_sk);
alter table web_returns add foreign key (wr_reason_sk) references reason (r_reason_sk);

--inventory
alter table inventory add foreign key (inv_date_sk) references date_dim (d_date_sk);
alter table inventory add foreign key (inv_item_sk) references time_dim (t_time_sk);
alter table inventory add foreign key (inv_warehouse_sk) references warehouse (w_warehouse_sk);

--store
alter table store add foreign key (s_closed_date_sk) references date_dim (d_date_sk);

--call_center
alter table call_center add foreign key (cc_closed_date_sk) references date_dim (d_date_sk);
alter table call_center add foreign key (cc_open_date_sk) references date_dim (d_date_sk);

--catalog_page
alter table catalog_page add foreign key (cp_start_date_sk) references date_dim (d_date_sk);
alter table catalog_page add foreign key (cp_end_date_sk) references date_dim (d_date_sk);

--web_site
alter table web_site add foreign key (web_open_date_sk) references date_dim (d_date_sk);
alter table web_site add foreign key (web_close_date_sk) references date_dim (d_date_sk);

--web_page
alter table web_page add foreign key (wp_creation_date_sk) references date_dim (d_date_sk);
alter table web_page add foreign key (wp_access_date_sk) references date_dim (d_date_sk);
alter table web_page add foreign key (wp_customer_sk) references customer (c_customer_sk);

--customer
alter table customer add foreign key (c_current_cdemo_sk) references customer_demographics (cd_demo_sk);
alter table customer add foreign key (c_current_hdemo_sk) references household_demographics (hd_demo_sk);
alter table customer add foreign key (c_current_addr_sk) references customer_address (ca_address_sk);
alter table customer add foreign key (c_first_shipto_date_sk) references date_dim (d_date_sk);
alter table customer add foreign key (c_first_sales_date_sk) references date_dim (d_date_sk);
alter table customer add foreign key (c_last_review_date) references date_dim (d_date_sk);

--household_demographics
alter table household_demographics add foreign key (hd_income_band_sk) references income_band (ib_income_band_sk);

--promotion
alter table promotion add foreign key (p_start_date_sk) references date_dim (d_date_sk);
alter table promotion add foreign key (p_end_date_sk) references date_dim (d_date_sk);
alter table promotion add foreign key (p_item_sk) references item (i_item_sk);
