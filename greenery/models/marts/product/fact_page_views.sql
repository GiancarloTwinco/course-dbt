WITH 

{%- set event_types = dbt_utils.get_column_values(
    table = ref('fct_events'),
    column = 'event_type'
  )
%}

base AS(
  SELECT
    user_country AS country,
    user_state AS state,
    COALESCE(order_product_name, 'NO PRODUCT') AS product_name,
    CAST(created_at AS DATE) AS event_date,
    CASE WHEN discount>0 THEN TRUE ELSE FALSE END AS has_discount,
    COUNT(DISTINCT session_guid) AS tot_sessions
    {%- for event_type in event_types %},
        SUM(CASE WHEN event_type = '{{ event_type }}' THEN 1 ELSE 0 END) AS {{ event_type }}s 
    {%- endfor %}
  FROM {{ ref('fct_events') }}
  GROUP BY 1,2,3,4,5
)

SELECT * FROM base