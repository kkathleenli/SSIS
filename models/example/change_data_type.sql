{%- set to_date=['"0CALDAY"','"0DOC_DATE"','"0CREATEDON"','"0PSTNG_DATE"'] -%}

{%- for col_name in to_date -%}
    {%- set condition_result = {{ data_type_condition_check( {{ col_name }} ) }} -%}
    {%- set status = condition_result.rows[0][0] if condition_result.rows|length > 0 else 'not change' -%}

    {%- if status == 'change' -%}
        {%- set change_to_date -%}
            SELECT CAST({{ col_name }} AS DATE) AS {{ col_name }}
            FROM {{ ref('create_table_test') }}
        {%- endset -%}
        {%- do run_query(change_to_date) -%}
    {%- endif -%}
{%- endfor -%}

data_type_condition_check("0CALDAY")