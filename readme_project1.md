How many users do we have?
    - 130 distinct users.

    ```select
        count(distinct user_id) as users
    from DEV_DB.DBT_ELISAPEDROSAREISMOLLIECOM.STG_POSTGRES_USERS
    ```

On average, how many orders do we receive per hour?
    - Avg. 7.5 orders per hour

    ```with order_per_hour as (
        select
            date_trunc(HOUR, order_created_at) as date_and_hour
            , count(distinct order_id) as orders
        from DEV_DB.DBT_ELISAPEDROSAREISMOLLIECOM.STG_POSTGRES_ORDERS
        group by 1)
    select avg(orders) from order_per_hour
    ```

On average, how long does an order take from being placed to being delivered?
    - Avg. 3.9 days from order created to delivered

    ```with delivery_days as (
        select
            order_id
            , order_created_at
            , delivered_at
            , datediff(DAY, order_created_at, delivered_at) delivery_days 
        from DEV_DB.DBT_ELISAPEDROSAREISMOLLIECOM.STG_POSTGRES_ORDERS
        where delivered_at is not null)
    select avg(delivery_days) from delivery_days
    ```


How many users have only made one purchase? Two purchases? Three+ purchases?
    -  25 users made only one order, 28 users made 2 orders, 71 have made more than three orders.
    
ORDERS	USERS
  1	    25
  2	    28
  3	    34
  4	    20
  5	    10
  6	    2
  7	    4
  8	    1

Note: you should consider a purchase to be a single order. In other words, if a user places one order for 3 products, they are considered to have made 1 purchase.

    ```with order_per_user as (
            select
            user_id, count(distinct order_id) as orders
        from DEV_DB.DBT_ELISAPEDROSAREISMOLLIECOM.STG_POSTGRES_ORDERS
        group by 1)
    select
        orders
        , count(distinct user_id) as users
    from order_per_user
    group by 1
    order by 1 
    ```


On average, how many unique sessions do we have per hour?
    - Avg. 16 sessions per hour

    ```with sessions_per_hour as (
        select 
            date_trunc(HOUR, created_at) as date_and_hour
            , count(distinct session_id) as sessions
        from DEV_DB.DBT_ELISAPEDROSAREISMOLLIECOM.STG_POSTGRES_EVENTS
        group by 1)
    select avg(sessions) from sessions_per_hour
    ```