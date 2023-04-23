{{config(
    materialized = 'table'
)
}}

with events_agg as (
select  *  from {{ ref('int_session_agg') }} 
)

, users as (
    select * from {{ ref('stg_postgres_users') }}  
)

select 
    session_id
    , events_agg.user_id
    , page_view_events
    , add_to_cart_events
    , package_shipped_events
    , checkout_events
    , session_start_at
    , session_end_at
    , first_name
    , last_name
    , email
    , user_created_at

from events_agg
left join users
    on events_agg.user_id = users.user_id

