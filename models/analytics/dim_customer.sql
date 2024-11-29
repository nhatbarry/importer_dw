with
  dim_customer__src as (
    SELECT
      *
    FROM
      `vit-lam-data.wide_world_importers.sales__customers`
  ),
  dim_customer__rename_cols as (
    select
      customer_id as customer_key,
      customer_name as customer_name,
      is_on_credit_hold as is_on_credit_hold,
      customer_category_id as customer_category_key,
      buying_group_id as buying_group_key
    from
      dim_customer__src
  ),
  dim_customer__cast_type as (
    select
      cast(customer_key as integer) as customer_key,
      cast(customer_name as string) as customer_name,
      cast(is_on_credit_hold as boolean) as is_on_credit_hold,
      cast(customer_category_key as integer) as customer_category_key,
      cast(buying_group_key as integer) as buying_group_key
    from
      dim_customer__rename_cols
  ),
  dim_customer__convert_boolean as (
    select
      customer_key,
      customer_name,
      case
        when is_on_credit_hold then 'On Creadit Hold'
        when not is_on_credit_hold then 'Not On Credit Hold'
        when is_on_credit_hold is null then 'Undefined'
        else 'Invalid'
      end as is_on_credit_hold,
      customer_category_key,
      buying_group_key
    from
      dim_customer__cast_type
  ),
  dim_customer__join as (
    select
      customer.customer_key,
      customer.customer_name,
      customer.is_on_credit_hold,
      customer.customer_category_key,
      category.customer_category_name,
      customer.buying_group_key,
      buying.buying_group_name
    from
      dim_customer__convert_boolean as customer
      left join {{ref("stg_buying_group")}} buying using (buying_group_key)
      left join {{ref("stg_customer_category")}} category using (customer_category_key)
  ),
  dim_customer__handle_null as (
    select 
      customer_key,
      customer_name,
      is_on_credit_hold,
      customer_category_key,
      coalesce(customer_category_name, 'Invalid') as customer_category_name,
      buying_group_key,
      coalesce(buying_group_name, 'Invalid') as buying_group_name
    from dim_customer__join
  )

  select * from dim_customer__handle_null