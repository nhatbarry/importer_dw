with
  dim_product__source as (
    select
      *
    from
      `vit-lam-data.wide_world_importers.warehouse__stock_items`
  ),
  dim_product__rename_col as (
    select
      stock_item_id as product_key,
      stock_item_name as product_name,
      brand as brand_name,
      is_chiller_stock as is_chiller_stock,
      supplier_id as supplier_key
    from
      dim_product__source
  ),
  dim_product__cast as (
    select
      cast(product_key as integer) as product_key,
      cast(product_name as string) as product_name,
      cast(brand_name as string) as brand_name,
      cast(is_chiller_stock as boolean) as is_chiller_stock,
      cast(supplier_key as integer) as supplier_key
    from
      dim_product__rename_col
  ),
  dim_product__convert_boolean as (
    select
      product_key,
      product_name,
      brand_name,
      case
        when is_chiller_stock then 'Chiller Stock'
        when not is_chiller_stock then 'Not Chiller Stock'
        when is_chiller_stock is null then 'Undefined'
        else 'Invalid'
      end as is_chiller_stock,
      supplier_key
    from
      dim_product__cast
  ),
  dim_product__join_supplier as (
    SELECT
      product.product_key,
      product.product_name,
      product.brand_name,
      product.supplier_key,
      product.is_chiller_stock,
      supplier.supplier_name
    FROM
      dim_product__convert_boolean as product
      left join {{ref("dim_supplier")}} as supplier using (supplier_key)
  ),
  dim_product__handle_null as (
    select
      product_key,
      product_name,
      is_chiller_stock,
      coalesce(brand_name, 'Undefined') as brand_name,
      supplier_key,
      coalesce(supplier_name, 'Invalid') as supplier_name
    from
      dim_product__join_supplier
  )

  select * from dim_product__handle_null