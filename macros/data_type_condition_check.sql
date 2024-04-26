{% macro data_type_condition_check(col_name) %}

   {% call statement('query',fetch_result=True) %}
   select case when COUNT(CHECK_VALUE) > 0 then 'not change' else 'change' end
   from (
   SELECT DISTINCT {{col_name}} AS CHECK_VALUE 
   FROM {{ source('snowflake_TEST', 'TEST_BILLING_CL_20240403_BACKUP') }}
   WHERE {{col_name}} LIKE '%#%'
   )
   {% endcall %}

   {% set results = load_result('query')['data'] %}

{% endmacro %}