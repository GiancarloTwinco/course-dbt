WITH base AS (
  SELECT 
    * 
  FROM {{ ref('stg_postgres__products') }}
)

SELECT * FROM base