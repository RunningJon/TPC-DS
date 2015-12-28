-- start query 44 in stream 3 using template query41.tpl
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 771 and 771+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'drab' or i_color = 'moccasin') and 
        (i_units = 'Cup' or i_units = 'Ton') and
        (i_size = 'petite' or i_size = 'economy')
        ) or
        (i_category = 'Women' and
        (i_color = 'cornsilk' or i_color = 'grey') and
        (i_units = 'Gross' or i_units = 'N/A') and
        (i_size = 'medium' or i_size = 'extra large')
        ) or
        (i_category = 'Men' and
        (i_color = 'navajo' or i_color = 'misty') and
        (i_units = 'Case' or i_units = 'Dozen') and
        (i_size = 'N/A' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'hot' or i_color = 'orchid') and
        (i_units = 'Gram' or i_units = 'Dram') and
        (i_size = 'petite' or i_size = 'economy')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'dim' or i_color = 'saddle') and 
        (i_units = 'Unknown' or i_units = 'Bundle') and
        (i_size = 'petite' or i_size = 'economy')
        ) or
        (i_category = 'Women' and
        (i_color = 'sandy' or i_color = 'light') and
        (i_units = 'Each' or i_units = 'Carton') and
        (i_size = 'medium' or i_size = 'extra large')
        ) or
        (i_category = 'Men' and
        (i_color = 'chocolate' or i_color = 'seashell') and
        (i_units = 'Ounce' or i_units = 'Box') and
        (i_size = 'N/A' or i_size = 'small')
        ) or
        (i_category = 'Men' and
        (i_color = 'burnished' or i_color = 'tomato') and
        (i_units = 'Pound' or i_units = 'Bunch') and
        (i_size = 'petite' or i_size = 'economy')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 44 in stream 3 using template query41.tpl
