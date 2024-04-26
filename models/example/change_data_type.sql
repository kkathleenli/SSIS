{%- set to_date=['"0CALDAY"','"0DOC_DATE"','"0CREATEDON"','"0PSTNG_DATE"'] -%}
{%- set cols = adapter.get_columns_in_relation({{ source('snowflake_TEST', 'TEST_BILLING_CL_20240403_BACKUP') }}) %}

{%- for col_name in cols -%}
    {% if col_name in to_date %}
    {% call statement('query',fetch_result=True) %}
    select case when COUNT(CHECK_VALUE) > 0 then 'not change' else 'change' end
    from (
    SELECT DISTINCT {{col_name}} AS CHECK_VALUE 
    FROM {{ source('snowflake_TEST', 'TEST_BILLING_CL_20240403_BACKUP') }}
    WHERE {{col_name}} LIKE '%#%'
    )
    {% endcall %}
    (% endif %)

    {% set results = load_result('query')['data'][0][0] %}

    {% if results == 'change' and not loop.last %}
    {% call statement(change_to_date) -%}
        SELECT CAST({{col_name}} AS DATE) AS {{col_name}}
        FROM {{ source('snowflake_TEST', 'TEST_BILLING_CL_20240403_BACKUP') }}
    {% endcall %}
    {% endif %}
{%- endfor -%}