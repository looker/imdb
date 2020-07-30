view: movie_info_idx {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: info {
    sql: ${TABLE}.info ;;
  }

  dimension: info_type_id {
    type: number
    sql: ${TABLE}.info_type_id ;;
  }

  dimension: movie_id {
    type: number
    sql: ${TABLE}.movie_id ;;
  }

  dimension: note {
    sql: ${TABLE}.note ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
