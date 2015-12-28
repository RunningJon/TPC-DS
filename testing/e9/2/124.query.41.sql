-- start query 24 in stream 1 using template query41.tpl
select  distinct(i_product_name)
 from item i1
 where i_manufact_id between 794 and 794+40 
   and (select count(*) as item_cnt
        from item
        where (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'slate' or i_color = 'violet') and 
        (i_units = 'Pallet' or i_units = 'Bunch') and
        (i_size = 'extra large' or i_size = 'petite')
        ) or
        (i_category = 'Women' and
        (i_color = 'papaya' or i_color = 'thistle') and
        (i_units = 'Pound' or i_units = 'Cup') and
        (i_size = 'N/A' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'almond' or i_color = 'burnished') and
        (i_units = 'N/A' or i_units = 'Dozen') and
        (i_size = 'medium' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'chartreuse' or i_color = 'beige') and
        (i_units = 'Carton' or i_units = 'Tsp') and
        (i_size = 'extra large' or i_size = 'petite')
        ))) or
       (i_manufact = i1.i_manufact and
        ((i_category = 'Women' and 
        (i_color = 'dim' or i_color = 'sandy') and 
        (i_units = 'Dram' or i_units = 'Tbl') and
        (i_size = 'extra large' or i_size = 'petite')
        ) or
        (i_category = 'Women' and
        (i_color = 'saddle' or i_color = 'indian') and
        (i_units = 'Lb' or i_units = 'Ton') and
        (i_size = 'N/A' or i_size = 'large')
        ) or
        (i_category = 'Men' and
        (i_color = 'chocolate' or i_color = 'forest') and
        (i_units = 'Each' or i_units = 'Gross') and
        (i_size = 'medium' or i_size = 'economy')
        ) or
        (i_category = 'Men' and
        (i_color = 'dark' or i_color = 'orange') and
        (i_units = 'Box' or i_units = 'Unknown') and
        (i_size = 'extra large' or i_size = 'petite')
        )))) > 0
 order by i_product_name
 limit 100;

-- end query 24 in stream 1 using template query41.tpl
