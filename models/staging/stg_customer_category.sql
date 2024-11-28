with
  customer_category__src as (
    select
      *
    from
      `vit-lam-data.wide_world_importers.sales__customer_categories`
  ),
  customer_category__rename_cols as (
    select
      customer_category_id as customer_category_key,
      customer_category_name as customer_category_name
    from
      customer_category__src
  ),
  customer_category__cast as (
    select
      cast(customer_category_key as integer) as customer_category_key,
      cast(customer_category_name as string) as customer_category_name
    from
      customer_category__rename_cols
  )
select
  customer_category_key,
  customer_category_name
from
  customer_category__cast