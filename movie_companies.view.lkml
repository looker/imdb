view: movie_companies {
  sql_table_name: lookerdata.imdb.movie_companies ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: company_id {
    type: number
    sql: ${TABLE}.company_id ;;
    hidden: yes
  }

  dimension: company_type_id {
    type: number
    sql: ${TABLE}.company_type_id ;;
    hidden: yes
  }

  dimension: movie_id {
    type: number
    sql: ${TABLE}.movie_id ;;
    hidden: yes
  }

  dimension: note {
    sql: ${TABLE}.note ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [id]
    hidden: yes
  }
}
