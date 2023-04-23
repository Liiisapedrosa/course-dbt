{{config(
    materialized = 'table'
)
}}

with products as (
    select * from {{ref('stg_postgres_products')}}
)

, pageviews as (
    select
        * 
    from {{ref('stg_postgres_events')}}
    where event_type = 'page_view'
)

, orders as (
    select * from {{ref('int_products_orders_agg')}}
)

select 
    products.product_id
    , product_name
    , product_price
    , inventory
    , total_orders
    , first_order_created_at
    , last_order_created_at
    , count(distinct session_id) as total_sessions
    , count(distinct event_id) as total_page_views
    , count(distinct user_id) as users_with_pageviews
    , MIN(pageviews.created_at) as first_pageview_created_at
    , MAX(pageviews.created_at) as last_pageview_created_at

from products 
left join pageviews
    on products.product_id = pageviews.product_id
left join orders
    on products.product_id = orders.product_id

group by 1,2,3,4,5,6,7