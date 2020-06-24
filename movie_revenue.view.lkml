#X# Note: failed to preserve comments during New LookML conversion
view: movie_revenue {
  derived_table: {
    sql: SELECT
        movie_id,
        MAX(max_revenue) as usa_revenue
      FROM ${movie_weekend_revenue.SQL_TABLE_NAME} as mr
      GROUP BY movie_id
       ;;
  }

  dimension: movie_id {
    primary_key: yes
    hidden: yes
  }

  dimension: usa_revenue {
    type: number
    hidden: yes
    value_format: "$#,##0.00 \M"
  }

  dimension: revenue {
    type: number
    hidden: yes
    sql: ${usa_revenue} ;;
    value_format: "$#,##0.00 \M"
  }

  measure: total_revenue {
    type: sum
    sql: ${revenue} ;;
    value_format: "$#,##0.00 \M"
  }

  measure: average_revenue {
    type: average
    sql: ${revenue} ;;
    value_format: "$#,##0.00 \M"
  }
}
