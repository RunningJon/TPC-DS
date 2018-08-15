create index idx_ss_sold_date_sk on store_sales (ss_sold_date_sk);
create index idx_ss_sold_time_sk on store_sales (ss_sold_time_sk);
create index idx_ss_item_sk on store_sales (ss_item_sk);
create index idx_ss_customer_sk on store_sales (ss_customer_sk);
create index idx_ss_cdemo_sk on store_sales (ss_cdemo_sk);
create index idx_ss_hdemo_sk on store_sales (ss_hdemo_sk);
create index idx_ss_addr_sk on store_sales (ss_addr_sk);
create index idx_ss_store_sk on store_sales (ss_store_sk);
create index idx_ss_promo_sk on store_sales (ss_promo_sk);
create index idx_ss_ticket_number on store_sales (ss_ticket_number);

create index idx_sr_returned_date_sk on store_returns (sr_returned_date_sk);
create index idx_sr_return_time_sk on store_returns (sr_return_time_sk);
create index idx_sr_item_sk on store_returns (sr_item_sk);
create index idx_sr_customer_sk on store_returns (sr_customer_sk);
create index idx_sr_cdemo_sk on store_returns (sr_cdemo_sk);
create index idx_sr_hdemo_sk on store_returns (sr_hdemo_sk);
create index idx_sr_addr_sk on store_returns (sr_addr_sk);
create index idx_sr_store_sk on store_returns (sr_store_sk);
create index idx_sr_reason_sk on store_returns (sr_reason_sk);
create index idx_sr_ticket_number on store_returns (sr_ticket_number);

create index idx_cs_sold_date_sk on catalog_sales (cs_sold_date_sk);
create index idx_cs_sold_time_sk on catalog_sales (cs_sold_time_sk);
create index idx_cs_ship_date_sk on catalog_sales (cs_ship_date_sk);
create index idx_cs_bill_customer_sk on catalog_sales (cs_bill_customer_sk);
create index idx_cs_bill_cdemo_sk on catalog_sales (cs_bill_cdemo_sk);
create index idx_cs_bill_hdemo_sk on catalog_sales (cs_bill_hdemo_sk);
create index idx_cs_bill_addr_sk on catalog_sales (cs_bill_addr_sk);
create index idx_cs_ship_customer_sk on catalog_sales (cs_ship_customer_sk);
create index idx_cs_ship_cdemo_sk on catalog_sales (cs_ship_cdemo_sk);
create index idx_cs_ship_hdemo_sk on catalog_sales (cs_ship_hdemo_sk);
create index idx_cs_ship_addr_sk on catalog_sales (cs_ship_addr_sk);
create index idx_cs_call_center_sk on catalog_sales (cs_call_center_sk);
create index idx_cs_catalog_page_sk on catalog_sales (cs_catalog_page_sk);
create index idx_cs_ship_mode_sk on catalog_sales (cs_ship_mode_sk);
create index idx_cs_warehouse_sk on catalog_sales (cs_warehouse_sk);
create index idx_cs_item_sk on catalog_sales (cs_item_sk);
create index idx_cs_promo_sk on catalog_sales (cs_promo_sk);
create index idx_cs_order_number on catalog_sales (cs_order_number);

create index idx_cr_returned_date_sk on catalog_returns (cr_returned_date_sk);
create index idx_cr_returned_time_sk on catalog_returns (cr_returned_time_sk);
create index idx_cr_item_sk on catalog_returns (cr_item_sk);
create index idx_cr_refunded_customer_sk on catalog_returns (cr_refunded_customer_sk);
create index idx_cr_refunded_cdemo_sk on catalog_returns (cr_refunded_cdemo_sk);
create index idx_cr_refunded_hdemo_sk on catalog_returns (cr_refunded_hdemo_sk);
create index idx_cr_refunded_addr_sk on catalog_returns (cr_refunded_addr_sk);
create index idx_cr_returning_customer_sk on catalog_returns (cr_returning_customer_sk);
create index idx_cr_returning_cdemo_sk on catalog_returns (cr_returning_cdemo_sk);
create index idx_cr_returning_hdemo_sk on catalog_returns (cr_returning_hdemo_sk);
create index idx_cr_returning_addr_sk on catalog_returns (cr_returning_addr_sk);
create index idx_cr_call_center_sk on catalog_returns (cr_call_center_sk);
create index idx_cr_catalog_page_sk on catalog_returns (cr_catalog_page_sk);
create index idx_cr_ship_mode_sk on catalog_returns (cr_ship_mode_sk);
create index idx_cr_warehouse_sk on catalog_returns (cr_warehouse_sk);
create index idx_cr_reason_sk on catalog_returns (cr_reason_sk);
create index idx_cr_order_number on catalog_returns (cr_order_number);

create index idx_ws_sold_date_sk on web_sales (ws_sold_date_sk);
create index idx_ws_sold_time_sk on web_sales (ws_sold_time_sk);
create index idx_ws_ship_date_sk on web_sales (ws_ship_date_sk);
create index idx_ws_item_sk on web_sales (ws_item_sk);
create index idx_ws_bill_customer_sk on web_sales (ws_bill_customer_sk);
create index idx_ws_bill_cdemo_sk on web_sales (ws_bill_cdemo_sk);
create index idx_ws_bill_hdemo_sk on web_sales (ws_bill_hdemo_sk);
create index idx_ws_bill_addr_sk on web_sales (ws_bill_addr_sk);
create index idx_ws_ship_customer_sk on web_sales (ws_ship_customer_sk);
create index idx_ws_ship_cdemo_sk on web_sales (ws_ship_cdemo_sk);
create index idx_ws_ship_hdemo_sk on web_sales (ws_ship_hdemo_sk);
create index idx_ws_ship_addr_sk on web_sales (ws_ship_addr_sk);
create index idx_ws_web_page_sk on web_sales (ws_web_page_sk);
create index idx_ws_web_site_sk on web_sales (ws_web_site_sk);
create index idx_ws_ship_mode_sk on web_sales (ws_ship_mode_sk);
create index idx_ws_warehouse_sk on web_sales (ws_warehouse_sk);
create index idx_ws_promo_sk on web_sales (ws_promo_sk);
create index idx_ws_order_number on web_sales (ws_order_number);

create index idx_wr_returned_date_sk on web_returns (wr_returned_date_sk);
create index idx_wr_returned_time_sk on web_returns (wr_returned_time_sk);
create index idx_wr_item_sk on web_returns (wr_item_sk);
create index idx_wr_refunded_customer_sk on web_returns (wr_refunded_customer_sk);
create index idx_wr_refunded_cdemo_sk on web_returns (wr_refunded_cdemo_sk);
create index idx_wr_refunded_hdemo_sk on web_returns (wr_refunded_hdemo_sk);
create index idx_wr_refunded_addr_sk on web_returns (wr_refunded_addr_sk);
create index idx_wr_returning_customer_sk on web_returns (wr_returning_customer_sk);
create index idx_wr_returning_cdemo_sk on web_returns (wr_returning_cdemo_sk);
create index idx_wr_returning_hdemo_sk on web_returns (wr_returning_hdemo_sk);
create index idx_wr_returning_addr_sk on web_returns (wr_returning_addr_sk);
create index idx_wr_web_page_sk on web_returns (wr_web_page_sk);
create index idx_wr_reason_sk on web_returns (wr_reason_sk);
create index idx_wr_order_number on web_returns (wr_order_number);

create index idx_inv_date_sk  on inventory (inv_date_sk );
create index idx_inv_item_sk  on inventory (inv_item_sk );
create index idx_inv_warehouse_sk on inventory (inv_warehouse_sk);

create index idx_s_closed_date_sk on store (s_closed_date_sk);

create index idx_cc_closed_date_sk on call_center (cc_closed_date_sk);
create index idx_cc_open_date_sk on call_center (cc_open_date_sk);

create index idx_cp_start_date_sk on catalog_page (cp_start_date_sk);
create index idx_cp_end_date_sk on catalog_page (cp_end_date_sk);

create index idx_web_open_date_sk on web_site (web_open_date_sk);
create index idx_web_close_date_sk on web_site (web_close_date_sk);

create index idx_wp_creation_date_sk on web_page (wp_creation_date_sk);
create index idx_wp_access_date_sk on web_page (wp_access_date_sk);
create index idx_wp_customer_sk on web_page (wp_customer_sk);

create index idx_c_current_cdemo_sk on customer (c_current_cdemo_sk);
create index idx_c_current_hdemo_sk on customer (c_current_hdemo_sk);
create index idx_c_current_addr_sk on customer (c_current_addr_sk);
create index idx_c_first_shipto_date_sk on customer (c_first_shipto_date_sk);
create index idx_c_first_sales_date_sk on customer (c_first_sales_date_sk);

create index idx_hd_income_band_sk on household_demographics (hd_income_band_sk);

create index idx_p_start_date_sk on promotion (p_start_date_sk);
create index idx_p_end_date_sk on promotion (p_end_date_sk);
create index idx_p_item_sk on promotion (p_item_sk);
