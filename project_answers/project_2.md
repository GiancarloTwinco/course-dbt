## Analytics Engineering - Giancarlo Gavotti

# PROJECT WEEK 2

### Question 1
What is our user repeat rate?

* 98% of users who purchased purchased a second time

``` 
  SELECT 
    COUNT_IF(has_more_than_one_order)/COUNT_IF(has_order) AS answer
  FROM DEV_DB.DBT_GIANCARLOGAVOTTITWINCOCAPITALCOM.USER_ORDER_FACTS
```

### Question 2
Which products had their inventory change from week 1 to week 2? 

 * Six products have been updated 

| 4cda01b9-62e2-46c5-830f-b7f262a58fb1 |

| 55c6a062-5f4a-4a8b-a8e5-05ea5e6715a3 |

| be49171b-9f72-4fc9-bf7a-9a52e259836b |

| fb0e8be7-5ac4-4a76-a1fa-2cc4bf0b2d80 |

| 689fb64e-a4a2-45c5-b9f2-480c2155624d |

| b66a7143-c18a-43bb-b5dc-06bb5d1d3160 |

``` 
  SELECT
    product_guid 
  FROM DEV_DB.DBT_GIANCARLOGAVOTTITWINCOCAPITALCOM.SNAPSHOT_PRODUCTS
  WHERE dbt_valid_to IS NOT NULL
``` 