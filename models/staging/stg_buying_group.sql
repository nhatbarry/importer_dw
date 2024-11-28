with
  buying_group__src as (
    select
      *
    from
      `vit-lam-data.wide_world_importers.sales__buying_groups`
  ),
  buying_group__rename_cols as (
    select
      buying_group_id as buying_group_key,
      buying_group_name as buying_group_name
    from
      buying_group__src
  ),
  buying_group__cast as (
    select
      cast(buying_group_key as integer) as buying_group_key,
      cast(buying_group_name as string) as buying_group_name
    from
      buying_group__rename_cols
  )
select
  buying_group_key,
  buying_group_name
from
  buying_group__cast