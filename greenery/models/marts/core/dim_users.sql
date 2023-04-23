{{config(
    materialized = 'table'
)
}}

with users as (
    select * from {{ref ('stg_postgres_users')}}
)

, addresses as (
    select * from {{ref('stg_postgres_addresses')}}
)

select
    user_id
    , first_name
    , last_name
    , email
    , phone_number
    , user_created_at
    , user_updated_at
    , address
    , state
    , zip_code
    , country
    
from users
join addresses 
    on users.user_address_id = addresses.address_id