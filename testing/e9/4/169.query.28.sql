-- start query 69 in stream 3 using template query28.tpl
select  *
from (select avg(ss_list_price) B1_LP
            ,count(ss_list_price) B1_CNT
            ,count(distinct ss_list_price) B1_CNTD
      from store_sales
      where ss_quantity between 0 and 5
        and (ss_list_price between 172 and 172+10 
             or ss_coupon_amt between 5265 and 5265+1000
             or ss_wholesale_cost between 39 and 39+20)) B1,
     (select avg(ss_list_price) B2_LP
            ,count(ss_list_price) B2_CNT
            ,count(distinct ss_list_price) B2_CNTD
      from store_sales
      where ss_quantity between 6 and 10
        and (ss_list_price between 3 and 3+10
          or ss_coupon_amt between 12553 and 12553+1000
          or ss_wholesale_cost between 6 and 6+20)) B2,
     (select avg(ss_list_price) B3_LP
            ,count(ss_list_price) B3_CNT
            ,count(distinct ss_list_price) B3_CNTD
      from store_sales
      where ss_quantity between 11 and 15
        and (ss_list_price between 13 and 13+10
          or ss_coupon_amt between 4041 and 4041+1000
          or ss_wholesale_cost between 54 and 54+20)) B3,
     (select avg(ss_list_price) B4_LP
            ,count(ss_list_price) B4_CNT
            ,count(distinct ss_list_price) B4_CNTD
      from store_sales
      where ss_quantity between 16 and 20
        and (ss_list_price between 128 and 128+10
          or ss_coupon_amt between 14134 and 14134+1000
          or ss_wholesale_cost between 8 and 8+20)) B4,
     (select avg(ss_list_price) B5_LP
            ,count(ss_list_price) B5_CNT
            ,count(distinct ss_list_price) B5_CNTD
      from store_sales
      where ss_quantity between 21 and 25
        and (ss_list_price between 178 and 178+10
          or ss_coupon_amt between 4697 and 4697+1000
          or ss_wholesale_cost between 46 and 46+20)) B5,
     (select avg(ss_list_price) B6_LP
            ,count(ss_list_price) B6_CNT
            ,count(distinct ss_list_price) B6_CNTD
      from store_sales
      where ss_quantity between 26 and 30
        and (ss_list_price between 182 and 182+10
          or ss_coupon_amt between 17927 and 17927+1000
          or ss_wholesale_cost between 78 and 78+20)) B6
limit 100;

-- end query 69 in stream 3 using template query28.tpl
