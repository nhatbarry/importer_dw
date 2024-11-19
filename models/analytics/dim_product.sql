with dim_product__source
as
(
  select * from `vit-lam-data.wide_world_importers.warehouse__stock_items`
)

, dim_product__rename_col
as
(
  select
    stock_item_id as product_key
    , stock_item_name as product_name
    , brand as brand_name
  from dim_product_source
)

, dim_product__cast
as
(
  select
  cast(product_key as integer) as product_key
  , cast(product_name as string) as product_name
  , cast(brand_name as string) as brand_name
  from dim_product_rename_col
)


SELECT 
  product_key
  , product_name
  , brand_name
FROM dim_product_cast
