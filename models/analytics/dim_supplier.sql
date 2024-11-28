with
  dim_supplier__src as (
    SELECT
      *
    FROM
      `vit-lam-data.wide_world_importers.purchasing__suppliers`
  ),
  dim_supplier__rename_cols as (
    select
      supplier_id as supplier_key,
      supplier_name as supplier_name
    from
      dim_supplier__src
  ),
  dim_supplier__cast as (
    select
      cast(supplier_key as integer) as supplier_key,
      cast(supplier_name as string) as supplier_name
    from
      dim_supplier__rename_cols
  )
select
  supplier_key,
  supplier_name
from
  dim_supplier__cast