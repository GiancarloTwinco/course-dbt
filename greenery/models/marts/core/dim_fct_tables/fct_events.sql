WITH base AS(
  SELECT 
    *
  FROM {{ ref('stg_postgres__events') }}
),

add_order_info AS(
  SELECT
    base.*,
    oi.product_name AS order_product_name,
    oi.status AS order_status,
    oi.discount,
    oi.user_country,
    oi.user_state
  FROM base
  LEFT JOIN {{ ref('fct_orders') }} oi
    ON base.order_guid=oi.order_guid
)

SELECT * FROM add_order_info

