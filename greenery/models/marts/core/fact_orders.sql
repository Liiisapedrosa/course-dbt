{{config(
    materialized = 'table'
)
}}

with orders as (
    select * from {{ ref('stg_postgres_orders') }} 
)

, order_items as (
    select * from {{ref('stg_postgres_order_items')}}
)

, promos as (
    select * from {{ref('stg_postgres_promos')}}
)

select 
    orders.order_id
    , user_id
    , order_created_at
    , order_cost
    , shipping_cost
    , order_total
    , promos.discount as promo_discount
    , orders.promo_id
    , shipping_service
    , estimated_delivery_at
    , delivered_at
    , status as order_status
    , count(distinct product_id) as product_variation
    , sum(quantity) as total_products
from orders
join order_items 
    on orders.order_id = order_items.order_id
left join promos
    on orders.promo_id = promos.promo_id
group by 1,2,3,4,5,6,7,8,9,10,11,12