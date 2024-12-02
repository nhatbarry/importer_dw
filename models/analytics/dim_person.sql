with
  dim_person__src as (
    SELECT
      *
    FROM
      `vit-lam-data.wide_world_importers.application__people`
  ),
  dim_person__rename_cols as (
    SELECT
      person_id as person_key,
      full_name as full_name
    from
      dim_person__src
  ),
  dim_person__cast_type as (
    SELECT
      cast(person_key as integer) as person_key,
      cast(full_name as string) as full_name
    from
      dim_person__rename_cols
  ),
  dim_person__add_rows as (
    select
      person_key,
      full_name
    from
      dim_person__cast_type
    union all
    select
      0 as person_key,
      'Undefined' as full_name
  )

  select * from dim_person__add_rows