{{% set to_date=['"0CALDAY"','"0DOC_DATE"','"0CREATEDON"','"0PSTNG_DATE"']%}}

{% for i in to_date %}
    {% if {{condition_check(i)}}='change' %}

        {{% set add_temp_col %}}
            alter TABLE {{ source('snowflake_TEST', 'TEST_BILLING_CL_20240403_BACKUP') }} ADD COLUMN COLUMN_NAME_TEMP DATE
        {{% endset %}}

        {% do run_query(add_temp_col) %}

        {{% set create_date %}}
            update {{ source('snowflake_TEST', 'TEST_BILLING_CL_20240403_BACKUP') }} SET COLUMN_NAME_TEMP = TO_DATE("{i}")
        {{% endset %}}

        {% do run_query(add_temp_col) %}
    



{% endif %}

    