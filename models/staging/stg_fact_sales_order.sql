with fact_sales_order__src
as
(
  select 
    *
  from `vit-lam-data.wide_world_importers.sales__orders`
),

fact_sales_order__rename_cols
as
(
  select
    order_id as sales_order_key
    , customer_id as customer_key
  from fact_sales_order__src
),

fact_sales_order__cast_type
as
(
  select 
    cast(sales_order_key as integer) as sales_order_key
    , cast(customer_key as integer) as customer_key
  from fact_sales_order__rename_cols
)

select 
  sales_order_key
  , customer_key
from fact_sales_order__cast_type