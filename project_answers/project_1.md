## Analytics Engineering - Giancarlo Gavotti

# PROJECT WEEK 1

### Question 1
How many users do we have?

* We have 130 users

``` SELECT COUNT( DISTINCT user_guid) FROM DEV_DB.DBT_GIANCARLOGAVOTTITWINCOCAPITALCOM.STG_POSTGRES__USERS ```

### Question 2
On average, how many orders do we receive per hour?

* On average we receive around 7.53 orders

``` 
  SELECT 
    COUNT(distinct order_guid)/(DATEDIFF('second', MIN(created_at),    
    MAX(created_at))/3600) AS avg_orders_per_hour 
  FROM DEV_DB.DBT_GIANCARLOGAVOTTITWINCOCAPITALCOM.STG_POSTGRES__ORDERS;
``` 

### Question 3
On average, how long does an order take from being placed to being delivered?

* On average it takes around 3.89 days to deliver an order

``` 
  SELECT
    AVG(DATEDIFF('DAY', created_at, delivered_at)) AS avg_delivery_time_minutes
  FROM DEV_DB.DBT_GIANCARLOGAVOTTITWINCOCAPITALCOM.STG_POSTGRES__ORDERS
  WHERE status = 'delivered';
``` 

### Question 4
How many users have only made one purchase? Two purchases? Three+ purchases?

* Users with 1 order are: 25
* Users with 1 order are: 28
* Users with 1 order are: 71

```
  WITH base AS(
    SELECT * FROM DEV_DB.DBT_GIANCARLOGAVOTTITWINCOCAPITALCOM.STG_POSTGRES__ORDERS
  ),
  
  count_orders AS(
    SELECT 
      user_guid,
      RANK() OVER (PARTITION BY user_guid ORDER BY created_at) AS number_of_orders
    FROM BASE
    ),
    
  calc_max_orders AS(
    SELECT
      DISTINCT user_guid,
      MAX(number_of_orders) AS max_orders
    FROM count_orders
    GROUP BY 1
  ),
  
  group_by_user AS(
    SELECT 
      CASE 
        WHEN max_orders=1 THEN 1
        WHEN max_orders=2 THEN 2
        ELSE 3
      END AS tot_orders,
      COUNT(*) AS number_of_cases
    FROM calc_max_orders
    GROUP BY 1
  )
  
  SELECT * FROM group_by_user
  ORDER BY 1
  ```
  
  ### Question 5
  On average, how many unique sessions do we have per hour?
  * On average 16.33 we have unique sessions per hour 
  
  ```
    WITH sess_per_hour AS (
      SELECT 
          DATE_TRUNC(hour, created_at) AS created_hour,
          COUNT(DISTINCT session_guid) AS sessions_per_hour
      FROM DEV_DB.DBT_GIANCARLOGAVOTTITWINCOCAPITALCOM.STG_POSTGRES__EVENTS
      GROUP BY created_hour
    )
    
    SELECT round(AVG(sessions_per_hour), 2)
    FROM sess_per_hour;
```