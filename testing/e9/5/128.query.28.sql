-- start query 28 in stream 4 using template query28.tpl
select  *
from (select avg(ss_list_price) B1_LP
            ,count(ss_list_price) B1_CNT
            ,count(distinct ss_list_price) B1_CNTD
      from store_sales
      where ss_quantity between 0 and 5
        and (ss_list_price between 136 and 136+10 
             or ss_coupon_amt between 9655 and 9655+1000
             or ss_wholesale_cost between 24 and 24+20)) B1,
     (select avg(ss_list_price) B2_LP
            ,count(ss_list_price) B2_CNT
            ,count(distinct ss_list_price) B2_CNTD
      from store_sales
      where ss_quantity between 6 and 10
        and (ss_list_price between 4 and 4+10
          or ss_coupon_amt between 13102 and 13102+1000
          or ss_wholesale_cost between 36 and 36+20)) B2,
     (select avg(ss_list_price) B3_LP
            ,count(ss_list_price) B3_CNT
            ,count(distinct ss_list_price) B3_CNTD
      from store_sales
      where ss_quantity between 11 and 15
        and (ss_list_price between 172 and 172+10
          or ss_coupon_amt between 14403 and 14403+1000
          or ss_wholesale_cost between 1 and 1+20)) B3,
     (select avg(ss_list_price) B4_LP
            ,count(ss_list_price) B4_CNT
            ,count(distinct ss_list_price) B4_CNTD
      from store_sales
      where ss_quantity between 16 and 20
        and (ss_list_price between 103 and 103+10
          or ss_coupon_amt between 3858 and 3858+1000
          or ss_wholesale_cost between 68 and 68+20)) B4,
     (select avg(ss_list_price) B5_LP
            ,count(ss_list_price) B5_CNT
            ,count(distinct ss_list_price) B5_CNTD
      from store_sales
      where ss_quantity between 21 and 25
        and (ss_list_price between 56 and 56+10
          or ss_coupon_amt between 7496 and 7496+1000
          or ss_wholesale_cost between 18 and 18+20)) B5,
     (select avg(ss_list_price) B6_LP
            ,count(ss_list_price) B6_CNT
            ,count(distinct ss_list_price) B6_CNTD
      from store_sales
      where ss_quantity between 26 and 30
        and (ss_list_price between 123 and 123+10
          or ss_coupon_amt between 1139 and 1139+1000
          or ss_wholesale_cost between 3 and 3+20)) B6
limit 100;

-- end query 28 in stream 4 using template query28.tpl
