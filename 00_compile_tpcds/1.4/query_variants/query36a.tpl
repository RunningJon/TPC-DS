 -- $Id: query36a.tpl,v 1.3 2007/12/12 23:39:54 jms Exp $
 define YEAR=random(1998,2002,uniform);
 define STATENUMBER=list(random(1, rowcount("active_states", "store"), uniform),8);
 define STATE_A=distmember(fips_county,[STATENUMBER.1], 3);
 define STATE_B=distmember(fips_county,[STATENUMBER.2], 3);
 define STATE_C=distmember(fips_county,[STATENUMBER.3], 3);
 define STATE_D=distmember(fips_county,[STATENUMBER.4], 3);
 define STATE_E=distmember(fips_county,[STATENUMBER.5], 3);
 define STATE_F=distmember(fips_county,[STATENUMBER.6], 3);
 define STATE_G=distmember(fips_county,[STATENUMBER.7], 3);
 define STATE_H=distmember(fips_county,[STATENUMBER.8], 3);
 define _LIMIT=100;
 
 with results as
 (select 
    sum(ss_net_profit) as ss_net_profit, sum(ss_ext_sales_price) as ss_ext_sales_price,
    sum(ss_net_profit)/sum(ss_ext_sales_price) as gross_margin
   ,i_category
   ,i_class
   ,0 as g_category, 0 as g_class
 from
    store_sales
   ,date_dim       d1
   ,item
   ,store
 where
    d1.d_year = [YEAR] 
    and d1.d_date_sk = ss_sold_date_sk
    and i_item_sk  = ss_item_sk 
    and s_store_sk  = ss_store_sk
    and s_state in ('[STATE_A]','[STATE_B]','[STATE_C]','[STATE_D]',
                 '[STATE_E]','[STATE_F]','[STATE_G]','[STATE_H]')
 group by i_category,i_class)
 ,
 results_rollup as
 (select gross_margin ,i_category ,i_class,0 as t_category, 0 as t_class, 0 as lochierarchy from results
 union
 select sum(ss_net_profit)/sum(ss_ext_sales_price) as gross_margin,
   i_category, NULL AS i_class, 0 as t_category, 1 as t_class, 1 as lochierarchy from results group by i_category
 union
 select sum(ss_net_profit)/sum(ss_ext_sales_price) as gross_margin,
   NULL AS i_category ,NULL AS i_class, 1 as t_category, 1 as t_class, 2 as lochierarchy from results)
 [_LIMITA] select [_LIMITB]
  gross_margin ,i_category ,i_class, lochierarchy,rank() over (
 	partition by lochierarchy, case when t_class = 0 then i_category end 
 	order by gross_margin asc) as rank_within_parent
 from results_rollup
 order by
   lochierarchy desc
  ,case when lochierarchy = 0 then i_category end
  ,rank_within_parent
  [_LIMITC];

