create index idx_customer_demographics_1 on customer_demographics (cd_marital_status, cd_education_status);
create index idx_customer_address_1 on customer_address (ca_state, ca_country);
create index idx_store_sales_1 on store_sales (ss_sales_price, ss_net_profit);
create index idx_store_sales_2 on store_sales (ss_quantity, ss_ext_sales_price, ss_net_profit);
create index idx_store_sales_quantity_1 on store_sales (ss_quantity);
create index idx_store_sales_quantity_2 on store_sales (ss_quantity, ss_list_price, ss_coupon_amt, ss_wholesale_cost);
create index idx_item_1 on item(i_category);
create index idx_item_2 on item(i_category, i_current_price);
