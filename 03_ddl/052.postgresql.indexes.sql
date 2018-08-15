
create index ss_sold_date_sk_index on store_sales (ss_sold_date_sk);
create index ss_sold_time_sk_index on store_sales (ss_sold_time_sk);
create index ss_item_sk_index on store_sales (ss_item_sk);
create index ss_customer_sk_index on store_sales (ss_customer_sk);
create index ss_cdemo_sk_index on store_sales (ss_cdemo_sk);
create index ss_hdemo_sk_index on store_sales (ss_hdemo_sk);
create index ss_addr_sk_index on store_sales (ss_addr_sk);
create index ss_store_sk_index on store_sales (ss_store_sk);
create index ss_promo_sk_index on store_sales (ss_promo_sk);
create index ss_ticket_number_index on store_sales (ss_ticket_number);

create index sr_returned_date_sk_index on store_returns (sr_returned_date_sk);
create index sr_return_time_sk_index on store_returns (sr_return_time_sk);
create index sr_item_sk on store_returns (sr_item_sk);
create index sr_customer_sk_index on store_returns (sr_customer_sk);
create index sr_cdemo_sk_index on store_returns (sr_cdemo_sk);
create index sr_hdemo_sk_index on store_returns (sr_hdemo_sk);
create index sr_addr_sk_index on store_returns (sr_addr_sk);
create index sr_store_sk_index on store_returns (sr_store_sk);
create index sr_reason_sk_index on store_returns (sr_reason_sk);
create index sr_ticket_number_index on store_returns (sr_ticket_number);

create index cs_sold_date_sk_index on catalog_sales (cs_sold_date_sk);
create index cs_sold_time_sk_index on catalog_sales (cs_sold_time_sk);
create index cs_ship_date_sk_index on catalog_sales (cs_ship_date_sk);
create index cs_bill_customer_sk_index on catalog_sales (cs_bill_customer_sk);
create index cs_bill_cdemo_sk_index on catalog_sales (cs_bill_cdemo_sk);
create index cs_bill_hdemo_sk_index on catalog_sales (cs_bill_hdemo_sk);
create index cs_bill_addr_sk_index on catalog_sales (cs_bill_addr_sk);
create index cs_ship_customer_sk_index on catalog_sales (cs_ship_customer_sk);
create index cs_ship_cdemo_sk_index on catalog_sales (cs_ship_cdemo_sk);
create index cs_ship_hdemo_sk_index on catalog_sales (cs_ship_hdemo_sk);
create index cs_ship_addr_sk_index on catalog_sales (cs_ship_addr_sk);
create index cs_call_center_sk_index on catalog_sales (cs_call_center_sk);
create index cs_catalog_page_sk_index on catalog_sales (cs_catalog_page_sk);
create index cs_ship_mode_sk_index on catalog_sales (cs_ship_mode_sk);
create index cs_warehouse_sk_index on catalog_sales (cs_warehouse_sk);
create index cs_item_sk_index on catalog_sales (cs_item_sk);
create index cs_promo_sk_index on catalog_sales (cs_promo_sk);
create index cs_order_number_index on catalog_sales (cs_order_number);

create index cr_returned_date_sk_index on catalog_returns (cr_returned_date_sk);
create index cr_returned_time_sk_index on catalog_returns (cr_returned_time_sk);
create index cr_item_sk_index on catalog_returns (cr_item_sk);
create index cr_refunded_customer_sk_index on catalog_returns (cr_refunded_customer_sk);
create index cr_refunded_cdemo_sk_index on catalog_returns (cr_refunded_cdemo_sk);
create index cr_refunded_hdemo_sk_index on catalog_returns (cr_refunded_hdemo_sk);
create index cr_refunded_addr_sk_index on catalog_returns (cr_refunded_addr_sk);
create index cr_returning_customer_sk_index on catalog_returns (cr_returning_customer_sk);
create index cr_returning_cdemo_sk_index on catalog_returns (cr_returning_cdemo_sk);
create index cr_returning_hdemo_sk_index on catalog_returns (cr_returning_hdemo_sk);
create index cr_returning_addr_sk_index on catalog_returns (cr_returning_addr_sk);
create index cr_call_center_sk_index on catalog_returns (cr_call_center_sk);
create index cr_catalog_page_sk_index on catalog_returns (cr_catalog_page_sk);
create index cr_ship_mode_sk_index on catalog_returns (cr_ship_mode_sk);
create index cr_warehouse_sk_index on catalog_returns (cr_warehouse_sk);
create index cr_reason_sk_index on catalog_returns (cr_reason_sk);
create index cr_order_number_index on catalog_returns (cr_order_number);

create index ws_sold_date_sk_index on web_sales (ws_sold_date_sk);
create index ws_sold_time_sk_index on web_sales (ws_sold_time_sk);
create index ws_ship_date_sk_index on web_sales (ws_ship_date_sk);
create index ws_item_sk_index on web_sales (ws_item_sk);
create index ws_bill_customer_sk_index on web_sales (ws_bill_customer_sk);
create index ws_bill_cdemo_sk_index on web_sales (ws_bill_cdemo_sk);
create index ws_bill_hdemo_sk_index on web_sales (ws_bill_hdemo_sk);
create index ws_bill_addr_sk_index on web_sales (ws_bill_addr_sk);
create index ws_ship_customer_sk_index on web_sales (ws_ship_customer_sk);
create index ws_ship_cdemo_sk_index on web_sales (ws_ship_cdemo_sk);
create index ws_ship_hdemo_sk_index on web_sales (ws_ship_hdemo_sk);
create index ws_ship_addr_sk_index on web_sales (ws_ship_addr_sk);
create index ws_web_page_sk_index on web_sales (ws_web_page_sk);
create index ws_web_site_sk_index on web_sales (ws_web_site_sk);
create index ws_ship_mode_sk_index on web_sales (ws_ship_mode_sk);
create index ws_warehouse_sk_index on web_sales (ws_warehouse_sk);
create index ws_promo_sk_index on web_sales (ws_promo_sk);
create index ws_order_number_index on web_sales (ws_order_number);

create index wr_returned_date_sk_index on web_returns (wr_returned_date_sk);
create index wr_returned_time_sk_index on web_returns (wr_returned_time_sk);
create index wr_item_sk_index on web_returns (wr_item_sk);
create index wr_refunded_customer_sk_index on web_returns (wr_refunded_customer_sk);
create index wr_refunded_cdemo_sk_index on web_returns (wr_refunded_cdemo_sk);
create index wr_refunded_hdemo_sk_index on web_returns (wr_refunded_hdemo_sk);
create index wr_refunded_addr_sk_index on web_returns (wr_refunded_addr_sk);
create index wr_returning_customer_sk_index on web_returns (wr_returning_customer_sk);
create index wr_returning_cdemo_sk_index on web_returns (wr_returning_cdemo_sk);
create index wr_returning_hdemo_sk_index on web_returns (wr_returning_hdemo_sk);
create index wr_returning_addr_sk_index on web_returns (wr_returning_addr_sk);
create index wr_web_page_sk_index on web_returns (wr_web_page_sk);
create index wr_reason_sk_index on web_returns (wr_reason_sk);
create index wr_order_number_index on web_returns (wr_order_number);

create index inv_item_sk_index on inventory (inv_item_sk);
create index inv_date_sk_index on inventory (inv_date_sk);
create index inv_warehouse_sk_index on inventory (inv_warehouse_sk);

create index cp_start_date_sk_index on catalog_page (cp_start_date_sk);
create index cp_end_date_sk_index on catalog_page (cp_end_date_sk);

create index wp_creation_date_sk_index on web_page (wp_creation_date_sk);
create index wp_access_date_sk_index on web_page (wp_access_date_sk);
create index wp_customer_sk_index on web_page (wp_customer_sk);

create index c_current_cdemo_sk_index on customer (c_current_cdemo_sk);
create index c_current_hdemo_sk_index on customer (c_current_hdemo_sk);
create index c_current_addr_sk_index on customer (c_current_addr_sk);
create index c_first_shipto_date_sk_index on customer (c_first_shipto_date_sk);
create index c_first_sales_date_sk_index on customer (c_first_sales_date_sk);


