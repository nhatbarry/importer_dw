with fact_sales_order_line__src
as
(
  select * from `vit-lam-data.wide_world_importers.sales__order_lines`
)

, fact_sales_order_line__rename
as
(
  SELECT 
    order_line_id as sales_order_line_key
  , quantity as quantity
  , unit_price as unit_price
  , stock_item_id as product_key
FROM fact_sales_order_line__src
)

, fact_sales_order_line__cast_type
as
(
  SELECT 
  cast(sales_order_line_key as integer) as sales_order_line_key
  , cast(quantity as integer) as quantity
  , cast(unit_price as numeric) as unit_price
  , cast(product_key as integer) as product_key
FROM fact_sales_order_line__rename
)

, fact_sales_order_line__calculated_measure
as
(
  select 
  sales_order_line_key
  , quantity
  , unit_price
  , product_key
  , (quantity * unit_price) as gross_amount
  from fact_sales_order_line__cast_type
)

SELECT 
  sales_order_line_key
  , quantity
  , unit_price
  , product_key
  , gross_amount
FROM fact_sales_order_line__calculated_measure