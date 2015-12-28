-- start query 62 in stream 0 using template query41.tpl
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 674 and 674+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'rose' or i_color = 'medium') and 
        (i_units = 'Tsp' or i_units = 'Pallet') and
        (i_size = 'extra large' or i_size = 'N/A')
        ) or
        (i_category = 'Women' and
        (i_color = 'powder' or i_color = 'coral') and
        (i_units = 'N/A' or i_units = 'Dram') and
        (i_size = 'petite' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'red' or i_color = 'chiffon') and
        (i_units = 'Tbl' or i_units = 'Case') and
        (i_size = 'economy' or i_size = 'medium')
        ) or
        (i_category = 'Men' and
        (i_color = 'pink' or i_color = 'lace') and
        (i_units = 'Gram' or i_units = 'Bunch') and
        (i_size = 'extra large' or i_size = 'N/A')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'firebrick' or i_color = 'maroon') and 
        (i_units = 'Oz' or i_units = 'Lb') and
        (i_size = 'extra large' or i_size = 'N/A')
        ) or
        (i_category = 'Women' and
        (i_color = 'seashell' or i_color = 'chartreuse') and
        (i_units = 'Pound' or i_units = 'Ounce') and
        (i_size = 'petite' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'slate' or i_color = 'plum') and
        (i_units = 'Cup' or i_units = 'Ton') and
        (i_size = 'economy' or i_size = 'medium')
        ) or
        (i_category = 'Men' and
        (i_color = 'violet' or i_color = 'dim') and
        (i_units = 'Each' or i_units = 'Carton') and
        (i_size = 'extra large' or i_size = 'N/A')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 62 in stream 0 using template query41.tpl
