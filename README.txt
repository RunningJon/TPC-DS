TPC-DS benchmark scripts for HAWQ and Greenplum database.

1.  Download the dbgen utility http://www.tpc.org/tpcds/

2.  Data files are expected to be in data/ directory and named the following:
call_center.psv
catalog_page.psv
catalog_returns.psv
catalog_sales.psv
customer.psv
customer_address.psv
customer_demographics.psv
date_dim.psv
dbgen_version.psv
household_demographics.psv
income_band.psv
inventory.psv
item.psv
promotion.psv
reason.psv
ship_mode.psv
store.psv
store_returns.psv
store_sales.psv
time_dim.psv
warehouse.psv
web_page.psv
web_returns.psv
web_sales.psv
web_site.psv

3.  The customer.psv file will need to be converted to UTF-8 like so:
cat customer.psv | recode iso-8859-1..u8 > customer_utf8.psv
mv customer.psv customer.bak
mv customer_utf8.psv customer.psv

4.  If you need to split the files, you will also need to update 01_ddl/rollout.sh to handle wild cards.

5.  Variables can be adjusted in variables.sh

6.  Functions can be adjusted in functions.sh.  Note: The storage settings for small, medium, and large tables are controlled in function.sh
