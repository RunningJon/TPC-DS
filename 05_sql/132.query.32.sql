:EXPLAIN_ANALYZE
-- start query 7 in stream 0 using template query32.tpl and seed 773627290
select  sum(cs_ext_discount_amt)  as "excess discount amount" 
from 
   catalog_sales 
   ,item 
   ,date_dim
where
i_manufact_id = 291
and i_item_sk = cs_item_sk 
and d_date between '2000-03-22' and 
        (cast('2000-03-22' as date) + '90 days'::interval)
and d_date_sk = cs_sold_date_sk 
and cs_ext_discount_amt  
     > ( 
         select 
            1.3 * avg(cs_ext_discount_amt) 
         from 
            catalog_sales 
           ,date_dim
         where 
              cs_item_sk = i_item_sk 
          and d_date between '2000-03-22' and
                             (cast('2000-03-22' as date) + '90 days'::interval)
          and d_date_sk = cs_sold_date_sk 
      ) 
limit 100;

-- end query 7 in stream 0 using template query32.tpl
