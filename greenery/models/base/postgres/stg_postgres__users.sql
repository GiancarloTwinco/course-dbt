WITH base AS(
  SELECT
    *
  FROM {{source('postgres','users')}}
),

rename_recast AS(
  SELECT
    user_id AS user_guid,
    first_name,
    last_name,
    email,
    phone_number,
    created_at,
    updated_at,
    address_id AS address_guid

  FROM base
)

SELECT * FROM rename_recast
