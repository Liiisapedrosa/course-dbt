{{config(
    materialized = 'table'
)
}}

with orders as (
    select * from {{ref('stg_postgres_orders')}}
)

, order_items as (
    select * from {{ref('stg_postgres_order_items')}}
)

select
    product_id
    , count(distinct orders.order_id) as total_orders
    , MIN(order_created_at) as first_order_created_at
    , MAX(order_created_at) as last_order_created_at
from orders 
join order_items
    on orders.order_id = order_items.order_id
group by 1