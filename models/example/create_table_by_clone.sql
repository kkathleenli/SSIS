{{ config(materialized='table') }}

with create_by_clone as (
    select *
    from TEST.TEMP.TEST_BILLING_CL_20240403 
)
select *
from create_by_clone