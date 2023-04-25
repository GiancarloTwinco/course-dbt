WITH base AS(
  SELECT
    user_country AS country,
    user_state AS state,
    COALESCE(order_product_name, 'NO PRODUCT') AS product_name,
    CAST(created_at AS DATE) AS event_date,
    CASE WHEN discount>0 THEN TRUE ELSE FALSE END AS has_discount,
    COUNT(DISTINCT session_guid) AS tot_sessions,
    SUM(CASE WHEN(event_type = 'page_view') THEN 1 ELSE 0 END) AS page_views,
    SUM(CASE WHEN(event_type = 'add_to_cart') THEN 1 ELSE 0 END) AS add_to_carts,
    SUM(CASE WHEN(event_type = 'package_shipped') THEN 1 ELSE 0 END) AS packages_shipped,
    SUM(CASE WHEN(event_type = 'checkout') THEN 1 ELSE 0 END) AS checkouts
  FROM {{ ref('fct_events') }}
  GROUP BY 1,2,3,4,5
)

SELECT * FROM base