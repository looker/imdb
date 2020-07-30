#
# Boxoffice data is stored as type 107.  The records we are interested in look like:
#  $99,999 (USA) 10 November 2012
#
# There is a number for each weekend.
#
view: movie_weekend_revenue {
  derived_table: {
    persist_for: "100 hours"
    sql: SELECT
        *
        , ROW_NUMBER() OVER(ORDER BY movie_id, weekend_date) as id
        , ROW_NUMBER() OVER(PARTITION BY movie_id ORDER BY weekend_date) as weekend_number
        , amount_to_date - COALESCE(LAG(amount_to_date) OVER (PARTITION BY movie_id ORDER BY weekend_date),0) as weekend_amount
        , MAX(amount_to_date) OVER(PARTITION BY movie_id) as max_revenue
      FROM (
        SELECT
          movie_id
          , info as info  -- DIALECT: {{ _dialect._name }}
          , {% if _dialect._name contains 'spark' %}
               CAST(REGEXP_REPLACE(SPLIT(info, ' ')[0],'[\\$,]','') AS DECIMAL(38,8)) / 1000000.0
            {% else %}
              CAST(REPLACE(REPLACE(SPLIT_PART(info,' ',1),'$',''),',','') AS NUMERIC) / 1000000.0
            {% endif %} as amount_to_date
          ,
            {% if _dialect._name contains 'spark' %}
               FROM_UNIXTIME(UNIX_TIMESTAMP(REGEXP_REPLACE(info,'^[^\)]*\\) \\(',''),'dd MMMMM yyy'),'yyy-MM-dd')
            {% else %}
               TO_DATE(RTRIM(REGEXP_SUBSTR(info,'[^\(]*$'),1),'DD Month YYYY')
            {% endif %}  as weekend_date
        FROM movie_info
        WHERE
          movie_info.info_type_id = 107
          AND
            {% if _dialect._name contains 'spark' %}
              info RLIKE '^\\$[\\d,]* \\(USA\\).*\\(.*\\)$'
            {% else %}
              info ILIKE '$%(USA)%(%)' and info ~ '\\d\\d [A-Z][a-z]* \\d\\d\\d\\d\\\)$'
            {% endif %}

      ) AS BOO
       ;;
  }

  dimension: id {
    hidden: yes
    primary_key: yes
  }

  dimension: movie_id {
    hidden: yes
  }

  dimension: weekend_amount {
    type: number
    value_format: "$#,##0.00 \M"
  }

  dimension: info {}

  dimension_group: weekend {
    type: time
    timeframes: [date]
    sql: ${TABLE}.weekend_date ;;
  }

  dimension: weekend_number {
    type: number
  }

  dimension: max_revenue {
    type: number
  }

  measure: total_amount {
    type: sum_distinct
    sql: ${max_revenue} ;;
    sql_distinct_key: ${movie_id} ;;
    value_format: "$#,##0.00 \M"
  }

  measure: average_amount {
    type: average
    sql: ${weekend_amount} ;;
    value_format: "$#,##0.00 \M"
  }
}
