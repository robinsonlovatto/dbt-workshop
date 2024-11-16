{{ config(
    schema='gold',
    materialized='table'
) }}

/* accumulated revenue by month, difference in percent and amount of money */


with monthly_revenues as (
    select
        extract(year from orders.order_date) as year,
        extract(month from orders.order_date) as month,
        sum(order_details.unit_price * order_details.quantity * (1.0 - order_details.discount)) as monthly_revenue
    from
        {{ ref('stg_orders') }} as orders
    inner join
        {{ ref('stg_order_details') }} as order_details on orders.order_id = order_details.order_id
    group by
        extract(year from orders.order_date),
        extract(month from orders.order_date)
),
accumulated_revenue as (
    select
        year,
        month,
        monthly_revenue,
        sum(monthly_revenue) over (partition by year order by month) as yearly_revenue_accum
    from
        monthly_revenues
)	
select
    year,
    month,
    monthly_revenue,
    monthly_revenue - lag(monthly_revenue) over (partition by year order by month) as diff_monthly,
    yearly_revenue_accum,
    (monthly_revenue - lag(monthly_revenue) over (partition by year order by month)) / lag(monthly_revenue) over (partition by year order by month) * 100 as diff_percent
from
    accumulated_revenue
order by
    year,
    month