{{ config(materialized='table') }}

with DBT_TEST AS (
    SELECT *
    FROM TEST.TEMP.TEST_BILLING_CL_20240403_BACKUP
)
select *
from DBT_TEST