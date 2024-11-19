with dim_customer__src
as
(
  SELECT 
  *
  FROM `vit-lam-data.wide_world_importers.sales__customers`
),

dim_customer__rename_cols
as
(
  select 
    customer_id as customer_key
    , customer_name as customer_name
  from dim_customer__src
),

dim_customer__cast_type
as
(
  select 
    cast(customer_key as integer) as customer_key
    , cast(customer_name as string) as customer_name
  from dim_customer__rename_cols
)

select
  customer_key
  , customer_name
from dim_customer__cast_type