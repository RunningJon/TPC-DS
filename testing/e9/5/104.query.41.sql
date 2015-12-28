-- start query 4 in stream 4 using template query41.tpl
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 972 and 972+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'snow' or i_color = 'khaki') and 
        (i_units = 'Cup' or i_units = 'Bunch') and
        (i_size = 'medium' or i_size = 'extra large')
        ) or
        (i_category = 'Women' and
        (i_color = 'orchid' or i_color = 'thistle') and
        (i_units = 'Case' or i_units = 'Carton') and
        (i_size = 'small' or i_size = 'petite')
        ) or
        (i_category = 'Men' and
        (i_color = 'cornsilk' or i_color = 'ivory') and
        (i_units = 'Unknown' or i_units = 'Gross') and
        (i_size = 'economy' or i_size = 'N/A')
        ) or
        (i_category = 'Men' and
        (i_color = 'cyan' or i_color = 'forest') and
        (i_units = 'Pallet' or i_units = 'Pound') and
        (i_size = 'medium' or i_size = 'extra large')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'sandy' or i_color = 'black') and 
        (i_units = 'N/A' or i_units = 'Tsp') and
        (i_size = 'medium' or i_size = 'extra large')
        ) or
        (i_category = 'Women' and
        (i_color = 'wheat' or i_color = 'slate') and
        (i_units = 'Bundle' or i_units = 'Ton') and
        (i_size = 'small' or i_size = 'petite')
        ) or
        (i_category = 'Men' and
        (i_color = 'yellow' or i_color = 'coral') and
        (i_units = 'Dozen' or i_units = 'Lb') and
        (i_size = 'economy' or i_size = 'N/A')
        ) or
        (i_category = 'Men' and
        (i_color = 'pale' or i_color = 'blush') and
        (i_units = 'Oz' or i_units = 'Box') and
        (i_size = 'medium' or i_size = 'extra large')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 4 in stream 4 using template query41.tpl
