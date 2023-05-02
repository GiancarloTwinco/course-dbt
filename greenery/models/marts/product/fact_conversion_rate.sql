WITH page_views AS(
  SELECT 
    product_guid, 
    SUM(CASE WHEN(event_type = 'page_view') THEN 1 ELSE 0 END) AS page_views  
  FROM {{ ref('fct_events') }} 
  GROUP BY 1
),

purchases AS (
  SELECT
    product_guid,
    product_name,
    COUNT(*) AS order_count
  FROM {{ ref('fct_orders') }}
  GROUP BY 1,2
),

final_table AS(
  SELECT
    p.*,
    pv.page_views,
    DIV0(pv.page_views,p.order_count) AS conversion_rate
  FROM purchases AS p
  LEFT JOIN page_views AS pv
  ON p.product_guid=pv.product_guid
)

SELECT * FROM final_table