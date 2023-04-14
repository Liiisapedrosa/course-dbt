{{config(
    materialized = 'table'
)
}}

with source as (
    select * from {{source('postgres', 'products') }}
)

select
    product_id
    , name as product_name
    , price as product_price
    , inventory

from source