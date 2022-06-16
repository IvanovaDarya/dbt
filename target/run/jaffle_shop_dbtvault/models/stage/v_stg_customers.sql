
  create view "postgres"."dbt"."v_stg_customers__dbt_tmp" as (
    








WITH staging AS (
-- Generated by dbtvault.



WITH source_data AS (

    SELECT

    id,
    first_name,
    last_name,
    email

    FROM "postgres"."dbt"."source_customers"
),

derived_columns AS (

    SELECT

    id,
    first_name,
    last_name,
    email,
    id::TEXT AS CUSTOMER_KEY,
    'CSV_CUSTOMERS'::TEXT AS RECORD_SOURCE

    FROM source_data
),

hashed_columns AS (

    SELECT

    id,
    first_name,
    last_name,
    email,
    CUSTOMER_KEY,
    RECORD_SOURCE,

    CAST((MD5(NULLIF(UPPER(TRIM(CAST(id AS VARCHAR))), ''))) AS TEXT) AS CUSTOMER_PK,
    CAST(MD5(CONCAT_WS('||',
        COALESCE(NULLIF(UPPER(TRIM(CAST(email AS VARCHAR))), ''), '^^'),
        COALESCE(NULLIF(UPPER(TRIM(CAST(first_name AS VARCHAR))), ''), '^^'),
        COALESCE(NULLIF(UPPER(TRIM(CAST(last_name AS VARCHAR))), ''), '^^')
    )) AS TEXT) AS CUSTOMER_HASHDIFF

    FROM derived_columns
),

columns_to_select AS (

    SELECT

    id,
    first_name,
    last_name,
    email,
    CUSTOMER_KEY,
    RECORD_SOURCE,
    CUSTOMER_PK,
    CUSTOMER_HASHDIFF

    FROM hashed_columns
)

SELECT * FROM columns_to_select
)

SELECT *, 
       current_timestamp AS LOAD_DATE,
       current_timestamp AS EFFECTIVE_FROM
FROM staging
  );