view: title_base {
  sql_table_name: `lookerdata.imdb.title` ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: imdb_id {
    type: number
    sql: ${TABLE}.imdb_id ;;
    hidden: yes
  }

  dimension: imdb_index {
    sql: ${TABLE}.imdb_index ;;
    hidden: yes
  }

  dimension: kind_id {
    type: number
    sql: ${TABLE}.kind_id ;;
    hidden: yes
  }

  dimension: title {
    sql: ${TABLE}.title ;;
  }

  dimension: production_year {
    type: number
    sql: ${TABLE}.production_year ;;
  }

  measure: count {
    type: count
    drill_fields: [id, title, production_year]
  }
}
