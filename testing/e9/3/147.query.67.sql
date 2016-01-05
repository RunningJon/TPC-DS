/*
drop table myrollup2;

create table myrollup2 as 
select i_category
                  ,i_class
                  ,i_brand
                  ,i_product_name
                  ,d_year
                  ,d_qoy
                  ,d_moy
                  ,s_store_id
                  ,mod((random()*1000)::int,1000) as tempval
                  ,sum(coalesce(ss_sales_price*ss_quantity,0)) sumsales
            from store_sales
                ,date_dim
                ,store
                ,item
       where  ss_sold_date_sk=d_date_sk
          and ss_item_sk=i_item_sk
          and ss_store_sk = s_store_sk
          and d_month_seq between 1212 and 1212+11
       group by  rollup(i_category, i_class, i_brand, i_product_name, d_year, d_qoy, d_moy,s_store_id)
distributed by (i_category, tempval)
;
*/
--explain analyze
select *
from (select  i_category
            ,i_class
            ,i_brand
            ,i_product_name
            ,d_year
            ,d_qoy
            ,d_moy
            ,s_store_id
            ,sumsales
            ,rank() over (partition by i_category order by sumsales desc) rk2
from (select i_category
            ,i_class
            ,i_brand
            ,i_product_name
            ,d_year
            ,d_qoy
            ,d_moy
            ,s_store_id
            ,sumsales
            ,rank() over (partition by i_category, tempval order by sumsales desc) rk
            from (select i_category
                  ,i_class
                  ,i_brand
                  ,i_product_name
                  ,d_year
                  ,d_qoy
                  ,d_moy
                  ,s_store_id
                  ,mod((random()*1000)::int,1000) as tempval
                  ,sum(coalesce(ss_sales_price*ss_quantity,0)) sumsales
            from store_sales
                ,date_dim
                ,store
                ,item
       where  ss_sold_date_sk=d_date_sk
          and ss_item_sk=i_item_sk
          and ss_store_sk = s_store_sk
          and d_month_seq between 1212 and 1212+11
       group by  rollup(i_category, i_class, i_brand, i_product_name, d_year, d_qoy, d_moy,s_store_id)
        ) inner1
      ) dw1
where rk <= 100
) dw2
where rk2 <= 100
order by i_category
        ,i_class
        ,i_brand
        ,i_product_name
        ,d_year
        ,d_qoy
        ,d_moy
        ,s_store_id
        ,sumsales
        ,rk2
limit 100
;
/*
--explain
SELECT a.i_category
        ,a.i_class
        ,a.i_brand
        ,a.i_product_name
        ,a.d_year
        ,a.d_qoy
        ,a.d_moy
        ,a.s_store_id
        ,a.sumsales
        --, rk 
FROM myrollup1 a
WHERE (
  SELECT count(*) as rk
  FROM myrollup1 b
  WHERE a.i_category = b.i_category
  AND a.sumsales <= b.sumsales
 ) <= 100
ORDER BY a.i_category
        ,a.i_class
        ,a.i_brand
        ,a.i_product_name
        ,a.d_year
        ,a.d_qoy
        ,a.d_moy
        ,a.s_store_id
        ,a.sumsales
        --, rk
LIMIT 100
*/

