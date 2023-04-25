WITH base AS (
  SELECT 
    * 
  FROM {{ ref('stg_postgres__users') }}
),

add_addresses AS(
  SELECT
    base.*,
    ad.country,
    ad.state
  FROM base
  LEFT JOIN {{ ref('stg_postgres__addresses') }} AS ad
    ON base.address_guid=ad.address_guid
)

SELECT * FROM add_addresses