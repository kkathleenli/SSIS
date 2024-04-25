{{ config(materialized='table') }}

with create_by_clone as (
    select *
    from KDB.PBI_SF.ZSD_C01_BILLING_EUR 
)
select *
from create_by_clone