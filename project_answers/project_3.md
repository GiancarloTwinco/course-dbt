## Analytics Engineering - Giancarlo Gavotti

# PROJECT WEEK 3

### Question 1
What is our overall conversion rate?e?

* The average conversion rate between all products is 2.19

``` 
  SELECT 
    AVG(conversion_rate) AS avg_conversion_rate
  FROM DEV_DB.DBT_GIANCARLOGAVOTTITWINCOCAPITALCOM.FACT_CONVERSION_RATE
```

### Question 2
What is our overall conversion rate?

 * The conversion rate per product is as follows:
Orchid	-> 2.205882

Ponytail Palm	-> 2.535714

Pink Anthurium	-> 2.387096

Bamboo	-> 1.916666

Spider Plant	-> 2.107142

Birds Nest Fern	-> 2.424242

ZZ Plant	-> 1.911764

Pothos	-> 3.047619

Ficus	-> 2.344827

Majesty Palm	-> 2.090909

Dragon Tree	-> 2.137931

Alocasia Polly	-> 2.571428

String of pearls	-> 1.666666

Angel Wings Begonia	-> 2.583333

Rubber -> Plant	2

Philodendron	-> 2.1

Jade Plant	-> 2.090909

Monstera	-> 1.96

Calathea Makoyana	-> 1.962962

Devil's Ivy	-> 2.045454

Peace Lily	-> 2.481481

Arrow Head	-> 1.828571

Boston Fern	-> 2.423076

Bird of Paradise	-> 2.222222

Aloe Vera	-> 2.03125

Pilea Peperomioides	-> 2.142857

Snake Plant	-> 2.517241

Money Tree	-> 2.153846

Cactus	-> 1.833333

Fiddle Leaf Fig	-> 2.107142


``` 
  SELECT 
    product_name, 
    conversion_rate
  FROM DEV_DB.DBT_GIANCARLOGAVOTTITWINCOCAPITALCOM.FACT_CONVERSION_RATE
``` 

### Question 3
Which products had their inventory change from week 2 to week 3? 

Pothos

Monstera

Philodendron

String of pearls

Bamboo

ZZ Plant

``` 
  SELECT
    distinct(product_guid), name 
  FROM DEV_DB.DBT_GIANCARLOGAVOTTITWINCOCAPITALCOM.SNAPSHOT_PRODUCTS
  WHERE dbt_valid_to IS NOT NULL
``` 
