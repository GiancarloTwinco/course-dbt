WITH base AS (
  SELECT 
    * 
  FROM {{ ref('stg_postgres__orders') }}
),

add_order_items AS(
  SELECT 
    base.*,
    oi.product_guid,
    oi.order_quantity
  FROM base
  LEFT JOIN (SELECT product_guid, order_guid, SUM(quantity) AS order_quantity FROM {{ ref('stg_postgres__order_items') }} GROUP BY 1,2)
    AS oi
    ON base.order_guid=oi.order_guid
),

add_promos AS(
  SELECT 
    base.*,
    pr.status AS promo_status,
    COALESCE(pr.discount,0) AS discount
  FROM add_order_items AS base
  LEFT JOIN {{ ref('stg_postgres__promos') }} AS pr
    ON base.promo_id=pr.promo_id
),

add_product_info AS(
  SELECT
    base.*,
    pr.name AS product_name
  FROM add_promos AS base
  LEFT JOIN {{ ref('dim_products') }} AS pr
    ON base.product_guid=pr.product_guid
),

add_user_info AS(
  SELECT
    base.*,
    us.state AS user_state,
    us.country AS user_country
  FROM add_product_info AS base
  LEFT JOIN {{ ref('dim_users') }} us
    ON base.user_guid=us.user_guid
)

SELECT * FROM add_user_info