--{% if is_incremental() %}
--    DROP TABLE IF EXISTS {{ ref('duplicated_table_name') }};
--{% endif %}


SELECT *
FROM {{ source('snowflake_TEST', 'TEST_BILLING_CL_20240403_BACKUP') }}