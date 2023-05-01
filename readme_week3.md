# Part 1

## What is our overall conversion rate?

62.46%

```
select
round(
    count(distinct (iff(checkout_events > 0, session_id,null)))
    /
    count(distinct session_id)
        *100, 2) as conversion_rate
from dev_db.dbt_elisapedrosareismolliecom.fact_sessions_users
```

## What is our conversion rate by product?

* PRODUCT_ID	                            PRODUCT_NAME	    CONVERSION_RATE
* fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80	String of pearls	61%
* 74aeb414-e3dd-4e8a-beef-0fa45225214d	Arrow Head	        56%
* c17e63f7-0d28-4a95-8248-b01ea354840e	Cactus	            55%
* b66a7143-c18a-43bb-b5dc-06bb5d1d3160	ZZ Plant	        54%
* 689fb64e-a4a2-45c5-b9f2-480c2155624d	Bamboo	            54%
* 579f4cd0-1f45-49d2-af55-9ab2b72c3b35	Rubber Plant	    52%
* b86ae24b-6f59-47e8-8adc-b17d88cbd367	Calathea Makoyana	51%
* be49171b-9f72-4fc9-bf7a-9a52e259836b	Monstera	        51%
* e706ab70-b396-4d30-a6b2-a1ccf3625b52	Fiddle Leaf Fig	    50%
* 615695d3-8ffd-4850-bcf7-944cf6d3685b	Aloe Vera	        49%
* 5ceddd13-cf00-481f-9285-8340ab95d06d	Majesty Palm	    49%
* 35550082-a52d-4301-8f06-05b30f6f3616	Devil's Ivy	        49%
* 55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3	Philodendron	    48%
* a88a23ef-679c-4743-b151-dc7722040d8c	Jade Plant	        48%
* 37e0062f-bd15-4c3e-b272-558a86d90598	Dragon Tree	        47%
* 64d39754-03e4-4fa0-b1ea-5f4293315f67	Spider Plant	    47%
* 5b50b820-1d0a-4231-9422-75e7f6b0cecf	Pilea Peperomioides	47%
* d3e228db-8ca5-42ad-bb0a-2148e876cc59	Money Tree	        46%
* 05df0866-1a66-41d8-9ed7-e2bbcddd6a3d	Bird of Paradise	45%
* c7050c3b-a898-424d-8d98-ab0aaad7bef4	Orchid	            45%
* 843b6553-dc6a-4fc4-bceb-02cd39af0168	Ficus	            43%
* bb19d194-e1bd-4358-819e-cd1f1b401c0c	Birds Nest Fern	    42%
* 80eda933-749d-4fc6-91d5-613d29eb126f	Pink Anthurium	    42%
* 6f3a3072-a24d-4d11-9cef-25b0b5f8a4af	Alocasia Polly	    41%
* e2e78dfc-f25c-4fec-a002-8e280d61a2f2	Boston Fern	        41%
* e5ee99b6-519f-4218-8b41-62f48f59f700	Peace Lily	        41%
* e8b6528e-a830-4d03-a027-473b411c7f02	Snake Plant	        40%
* e18f33a6-b89a-4fbc-82ad-ccba5bb261cc	Ponytail Palm	    40%
* 58b575f2-2192-4a53-9d21-df9a0c14fc25	Angel Wings Begonia	39%
* 4cda01b9-62e2-46c5-830f-b7f262a58fb1	Pothos	            34%

```
select 
product_id
, product_name
, round(total_orders/total_sessions*100,0) as conversion_rate
from dev_db.dbt_elisapedrosareismolliecom.dim_products
order by 3 desc
```


When a product has a lower conversion rate it means people went into the page but didn't complete the purchase, meaning there was interest in the product in the beginning. This might be related to how the product is displayed, which we can investigate by comparing the pages of high converting vs low converting products. Some elements to compare might be the picture quality, the pricing (are the high conversion products cheaper? how it the low conversion product pricing compared to competitors?), the amount of options (are there color variations for the vase for example). Also it might be worth checking if there are any UI differences between the pages that might make user experience more difficult in the low converting products.

# Part 2: Macros

I couldn't think of another macro to improve the model, so I just created the example from Jake about group event types for the events agg table.

/workspace/course-dbt/greenery/macros/event_type_macro.sql

# Part 3: permissions

I created the reporting role and edited the mole to filter access.

[Link to screenshot of activity on snowflake giving access to the reporting role after running the model](https://github.com/Liiisapedrosa/course-dbt/blob/main/Screenshot%202023-05-01%20at%2015.01.43.png)

# Part 4: packages

I installed the package dbt_utils, which I needed to create the macro for events. 

/workspace/course-dbt/greenery/packages.yml

# Part 5: DAG

[Link to screenshot of DAG taken on May 1st](https://github.com/Liiisapedrosa/course-dbt/blob/main/Screenshot%202023-05-01%20at%2015.06.31.png)

# Part 6: snapshot

The product changes were as follows:

* Pothos inventory from 20 to 0
* Philodendron inventory from 25 to 15
* Bamboo inventory from 56 to 44
* ZZ Plant inventory from 89 to 53
* Monstera inventory from 64 to 50
* String of pearls inventory from 10 to 0


