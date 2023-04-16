## Analytics Engineering - Giancarlo Gavotti

# PROJECT WEEK 1

### Question 1

* How many users do we have?

We have 130 users

``` SELECT COUNT( DISTINCT user_guid) FROM DEV_DB.DBT_GIANCARLOGAVOTTITWINCOCAPITALCOM.STG_POSTGRES__USERS ```

* On average, how many orders do we receive per hour?

On average we receive around 7.53 orders

``` 
  SELECT 
    COUNT(distinct order_guid)/(DATEDIFF('second', MIN(created_at),    
    MAX(created_at))/3600) AS avg_orders_per_hour 
  FROM DEV_DB.DBT_GIANCARLOGAVOTTITWINCOCAPITALCOM.STG_POSTGRES__ORDERS;
``` 

* On average, how long does an order take from being placed to being delivered?

On average it takes around 3.89 days to deliver an order

``` 
  SELECT
    AVG(DATEDIFF('DAY', created_at, delivered_at)) AS avg_delivery_time_minutes
  FROM DEV_DB.DBT_GIANCARLOGAVOTTITWINCOCAPITALCOM.STG_POSTGRES__ORDERS
  WHERE status = 'delivered';
``` 

* How many users have only made one purchase? Two purchases? Three+ purchases?


* On average, how many unique sessions do we have per hour?