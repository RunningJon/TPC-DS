#!/bin/bash
set -e

source ../functions.sh
get_version

beg="CREATE TABLE tpcds.store_sales (
    ss_sold_date_sk integer,
    ss_sold_time_sk integer,
    ss_item_sk integer NOT NULL,
    ss_customer_sk integer,
    ss_cdemo_sk integer,
    ss_hdemo_sk integer,
    ss_addr_sk integer,
    ss_store_sk integer,
    ss_promo_sk integer,
    ss_ticket_number integer NOT NULL,
    ss_quantity integer,
    ss_wholesale_cost numeric(7,2),
    ss_list_price numeric(7,2),
    ss_sales_price numeric(7,2),
    ss_ext_discount_amt numeric(7,2),
    ss_ext_sales_price numeric(7,2),
    ss_ext_wholesale_cost numeric(7,2),
    ss_ext_list_price numeric(7,2),
    ss_ext_tax numeric(7,2),
    ss_coupon_amt numeric(7,2),
    ss_net_paid numeric(7,2),
    ss_net_paid_inc_tax numeric(7,2),
    ss_net_profit numeric(7,2)
)
WITH ($LARGE_STORAGE)
DISTRIBUTED BY (ss_item_sk)
PARTITION BY RANGE (ss_sold_date_sk) ("

counter=0
for i in $(psql -A -t -c "select d_year, min(ss_sold_date_sk) as min, max(ss_sold_date_sk) + 1 as max from ext_tpcds.store_sales left outer join ext_tpcds.date_dim on ss_sold_date_sk = d_date_sk group by d_year order by 1"); do
	let counter=counter+1
	year=`echo $i | awk -F '|' '{print $1}'`
	start=`echo $i | awk -F '|' '{print $2}'`
	end=`echo $i | awk -F '|' '{print $3}'`

	if [ "$counter" -gt "1" ]; then
		parts="$parts,"
	fi

	if [ "$year" == "" ]; then
		parts="$parts DEFAULT PARTITION no_date_set"
	else
		parts="$parts PARTITION y_$year START ($start) END ($end)"
	fi
done

create_table="$beg $parts );"
echo $create_table

psql -c "$create_table"
