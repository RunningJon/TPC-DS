-- start query 67 in stream 2 using template query22.tpl
select  i_product_name
             ,i_brand
             ,i_class
             ,i_category
             ,avg(inv_quantity_on_hand) qoh
       from inventory
           ,date_dim
           ,item
           ,warehouse
       where inv_date_sk=d_date_sk
              and inv_item_sk=i_item_sk
              and inv_warehouse_sk = w_warehouse_sk
              and d_month_seq between 1209 and 1209 + 11
       group by rollup(i_product_name
                       ,i_brand
                       ,i_class
                       ,i_category)
order by qoh, i_product_name, i_brand, i_class, i_category
limit 100;

-- end query 67 in stream 2 using template query22.tpl
