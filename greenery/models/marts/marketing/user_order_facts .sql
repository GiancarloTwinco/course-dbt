WITH base AS (
  SELECT
    * 
  FROM {{ ref('dim_users') }}
),

add_order_info AS(
  SELECT
    base.*,
    CASE WHEN  COALESCE(oi.tot_orders,0)>0 THEN TRUE ELSE FALSE END AS has_order,
    CASE WHEN  COALESCE(oi.tot_orders,0)>=2 THEN TRUE ELSE FALSE END AS has_more_than_one_order,
    COALESCE(oi.tot_orders,0) AS tot_orders
  FROM base
  LEFT JOIN (SELECT distinct user_guid, SUM(order_quantity) as tot_orders FROM {{ ref('fct_orders') }} GROUP BY 1) AS oi
  ON base.user_guid=oi.user_guid
)

SELECT * FROM add_order_info