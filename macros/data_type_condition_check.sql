{% macro condition_check(col_name) %}

with temp as (
SELECT DISTINCT {{col_name}} AS CHECK_VALUE 
FROM {{ source('snowflake_TEST', 'TEST_BILLING_CL_20240403_BACKUP') }} 
WHERE {{col_name}} LIKE '%#%'
)
select case when COUNT(CHECK_VALUE) > 0 then 'not change' else 'change' end 
from temp

{% endmacro %}
