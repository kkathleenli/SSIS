{{config(materialized='table')}}

--{% if is_incremental() %}
--    DROP TABLE IF EXISTS TEST.TEMP.TEST_DBT_BILLING;
--{% endif %}

-- Create the new table
CREATE TABLE TEST.TEMP.TEST_DBT_BILLING AS (
    SELECT *
    FROM TEST.TEMP.TEST_BILLING_CL_20240403
)

