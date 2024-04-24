select
    NAME,
    CAST(RIGHT(ADDRESS,6) AS VARCHAR(6)) AS PIN
FROM {{ source('PERSON','PERSON_DETAILS')}}


{{% set to_date=['"0CALDAY"','"0DOC_DATE"','"0CREATEDON"','"0PSTNG_DATE"']%}}

{% for i in to_date %}
    {% if {{condition_check(i)}}='change' %}
        