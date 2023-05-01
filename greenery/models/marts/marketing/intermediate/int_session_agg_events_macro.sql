{{
    config(
        MATERIALIZED = 'table'
    )
}}

with events as (
    select * from {{ ref('stg_postgres_events') }} 
)

select
    session_id
    , user_id

    {%- for event_type in event_types %}
    , sum(case when event_type = '{{ event_type }}' then 1 else 0 end) as {{ event_type }}s
    {%- endfor %}
    , MIN(created_at) as session_start_at
    , MAX(created_at) as session_end_at
    
from events
group by 1,2
