# Part 1. Models

## What is our user repeat rate

- 76%


```select
sum(case when orders > 1 then 1 else 0 end) as repeat_users
, count(distinct user_id) as users
, round(sum(case when orders > 1 then 1 else 0 end)/count(distinct user_id),2) as repeat_rate

from dev_db.dbt_elisapedrosareismolliecom.fact_user_orders
```

## What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again? If you had more data, what features would you want to look into to answer this question?

- A good indicator can be their daily/weekly/monthly recurrance and that can be used to indicate when they will stop ordering as well. Indicators on an order level can be how long it took to deliver, which is possible to measure with the data available, or if there was any cancelation on the order, any issues with delivery or also if the order was returned after delivered, which are not possible to measure with the data points available.

## Model layers created:
. marts
    . product
        . intermediate
        - fact_page_views: all pageview events, as state in the project instructions, so you can answer the question of daily pageviews per product and study traffic
    . marketing
        . intermediate
            - int_session_agg: table aggregating sessions and compiling the events inside each session to end up with one row per session
        - fact_session_users: table that uses the int_session_agg to build a view of each session combined with user info
        - fact_user_orders: table with each user and all their orders, so can be used to answer questions such as what is the repeat rate and also if the user is using promos, how much money they have spent with Greenery, when was their last order and where is their address (state, country) which can be helpful for marketing analysis
    . core: 
        . intermediate:
            - int_products_orders_agg: aggregation on a product level of all the orders created with the product and when was the first and last time the product was in an order
        - dim_products: combination of page views and order info on a product level so you can know how many times a product was viewed, purchased and calculate if a product is getting traffic but not converting to order
        - dim_users: table with all users and their addresses
        - fact_orders: all orders with their promos details, how many products was there in the order and how many different types of products

[Link to the DAG model layers](https://github.com/Liiisapedrosa/course-dbt/blob/main/Screenshot%202023-04-23%20at%2016.22.42.png)

## Part 2. Tests

I added tests into every model of the marts folder to check for the primary key (usually the ID) column if the column is not null and unique. The main concern is that through the transformations I would end up with duplicated rows for the unique IDs, or with null values because of wrongly placed join statements.

I didn't find any bad data. I think in order to keep a healthy data base it's important to have consistency tests, such as unique and not null, but also logical tests that check against the business rules to make sure the data is aligned with how the product works.

## Part 3. dbt Snapshots

I ran the dbt snapshot command the table showed unique value per product ID without any changes in inventory from last week. It might be possible I did the snapshot wrong last week, so it didn't record any changes now.
