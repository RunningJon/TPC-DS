-- start query 92 in stream 2 using template query41.tpl
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 907 and 907+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'navy' or i_color = 'cornflower') and 
        (i_units = 'Pound' or i_units = 'Bunch') and
        (i_size = 'small' or i_size = 'N/A')
        ) or
        (i_category = 'Women' and
        (i_color = 'papaya' or i_color = 'blue') and
        (i_units = 'Gross' or i_units = 'Tbl') and
        (i_size = 'large' or i_size = 'extra large')
        ) or
        (i_category = 'Men' and
        (i_color = 'ghost' or i_color = 'saddle') and
        (i_units = 'Ton' or i_units = 'Case') and
        (i_size = 'economy' or i_size = 'petite')
        ) or
        (i_category = 'Men' and
        (i_color = 'tomato' or i_color = 'cream') and
        (i_units = 'Lb' or i_units = 'Unknown') and
        (i_size = 'small' or i_size = 'N/A')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'burlywood' or i_color = 'navajo') and 
        (i_units = 'Carton' or i_units = 'Dozen') and
        (i_size = 'small' or i_size = 'N/A')
        ) or
        (i_category = 'Women' and
        (i_color = 'lace' or i_color = 'lawn') and
        (i_units = 'Tsp' or i_units = 'N/A') and
        (i_size = 'large' or i_size = 'extra large')
        ) or
        (i_category = 'Men' and
        (i_color = 'purple' or i_color = 'cyan') and
        (i_units = 'Bundle' or i_units = 'Ounce') and
        (i_size = 'economy' or i_size = 'petite')
        ) or
        (i_category = 'Men' and
        (i_color = 'thistle' or i_color = 'misty') and
        (i_units = 'Cup' or i_units = 'Gram') and
        (i_size = 'small' or i_size = 'N/A')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 92 in stream 2 using template query41.tpl
