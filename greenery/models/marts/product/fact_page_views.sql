{{config(
    materialized = 'table'
)
}}

with events as (
    select * from {{ref('stg_postgres_events')}}
)

select
    event_id
    , session_id
    , user_id
    , page_url
    , created_at 
    , product_id
from events
where event_type = 'page_view'