-- depends_on: {{ ref('create_table_by_clone') }}

{%- set to_date=['"0CALDAY"','"0DOC_DATE"','"0CREATEDON"','"0PSTNG_DATE"'] -%}

{%- for col_name in to_date -%}
    
    {% call statement('query',fetch_result=True) %}
    select case when COUNT(CHECK_VALUE) > 0 then 'not change' else 'change' end
    from (
    SELECT DISTINCT {{col_name}} AS CHECK_VALUE 
    FROM {{ ref("create_table_by_clone") }}
    WHERE {{col_name}} LIKE '%#%'
    )
    {% endcall %}

    {% set results = load_result('query')['data'][0][0] %}

    {% if results == 'change' and not loop.last %}
    {% call statement(change_to_date) -%}
    ALTER TABLE {{ ref("create_table_by_clone") }} ADD COLUMN COLUMN_NAME_TEMP DATE;
    UPDATE {{ ref("create_table_by_clone") }} 
    SET COLUMN_NAME_TEMP = TO_DATE({{col_name}});
    ALTER TABLE {{ ref("create_table_by_clone") }} DROP COLUMN {{col_name}};
    ALTER TABLE {{ ref("create_table_by_clone") }} RENAME COLUMN COLUMN_NAME_TEMP to {{col_name}};
    {% endcall %}
    {% endif %}


{%- endfor -%}
