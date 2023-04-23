{{config(
    materialized = 'table'
)
}}

with users as (
    select * from {{ref('dim_users')}}
)

, orders as (
    select * from {{ref('fact_orders')}}
)

select
    users.user_id
    , first_name
    , last_name
    , email
    , phone_number
    , user_created_at
    , address
    , state
    , zip_code
    , country
    , count(distinct order_id) orders
    , MIN(order_created_at) as first_order_created_at
    , MAX(order_created_at) as last_order_created_at
    , sum(order_cost) as total_order_cost
    , sum(shipping_cost) as total_shipping_cost
    , sum(order_total) as total_cost
    , sum(promo_discount) as total_promo_dicounts
    , sum(case when promo_id is not null then 1 else 0 end) as promos_used
    , sum(case when status = 'shipped' then 1 else 0 end) as shipped_orders
    , sum(case when status = 'delivered' then 1 else 0 end) as delivered_orders
    , sum(case when status = 'preparing' then 1 else 0 end) as preparing_orders
    , sum(total_products) as total_products
from users
left join orders
    on users.user_id = orders.user_id
group by 1,2,3,4,5,6,7,8,9,10