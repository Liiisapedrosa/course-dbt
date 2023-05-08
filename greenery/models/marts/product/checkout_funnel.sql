{{config(
    materialized = 'table'
)
}}

with fact_sessions_users as (
    select * from {{ref('fact_sessions_users')}}

)

select

    DATE(session_start_at) as session_date
    , sum(case when page_view_events > 0 then 1 else 0 end) has_page_view_event
    , sum(case when add_to_cart_events > 0 then 1 else 0 end) has_add_to_cart_event
    , sum(case when checkout_events > 0 then 1 else 0 end) has_checkout_events

from fact_sessions_users
group by 1