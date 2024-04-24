with temp as (
SELECT DISTINCT '0CALDAY' AS CHECK_VALUE 
FROM {{ source('snowflake_TEST', 'TEST_BILLING_CL_20240403_BACKUP') }} 
WHERE '0CALDAY' ILIKE '%#%'
)
select case when COUNT(CHECK_VALUE) > 0 then 'not change' else 'change' end 
from temp