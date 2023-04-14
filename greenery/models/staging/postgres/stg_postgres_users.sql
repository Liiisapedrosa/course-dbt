{{config(
    materialized = 'table'
)
}}

with source as (
    select * from {{source('postgres', 'users') }}
)

select 
    user_id
    , first_name
    , last_name
    , email
    , phone_number
    , created_at as user_created_at
    , updated_at as user_updated_at
    , address_id as user_address_id

from source