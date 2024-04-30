{% call statement('get_target_col_name',fetch_result=True) %}
    SELECT D.*,C.TXTSH,C.TXTLG
    FROM TEST.TEMP.TEST_OBJ_ZSDC01_KH_20240418 D
    INNER JOIN  TEST.TEMP.TEST_OBJ_KH_20240418 C
    ON C.IOBJNM=D.IOBJNM AND C.OBJVERS=D.OBJVERS
    WHERE LANGU='E'
{% endcall %}

{% set column_mapping = load_result('get_target_col_name') %}

{% set target_billing = adapter.get_columns_in_relation( ref("create_table_by_clone")) %}

{% set new_col_name={} %}
{% for i in target_billing %}
    {% for row in column_mapping %}
       {% if i.name.startswith('2') and '2' ~ row.IOBJNM == i.name %}
       {% set _ = new_col_name.update({i.name: (row.TXTSH ~ '_key').replace(' ', '_')}) %}
       {% elif (i.name.startswith('5') and '5' ~ row.IOBJNM == i.name) or (i.name.startswith('0') and i.name == row.IOBJNM) or (i.name.startswith('Z') and i.name == row.IOBJNM) %}
       {% set _ = new_col_name.update({i.name: row.TXTSH.replace(' ', '_')}) %}
       {% endif %}
    {% endfor %}
{% endfor %}

{% for k, v in new_col_name.items() %}
    {% call statement(change_name,fetch_result=True) -%}
    alter table {{ ref("create_table_by_clone") }} rename column {{ k }} to {{ v }};
    {% endcall %}
{% endfor %} 

select *
from {{ ref("create_table_by_clone") }}

