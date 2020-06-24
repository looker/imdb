view: complete_cast {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: movie_id {
    type: number
    sql: ${TABLE}.movie_id ;;
  }

  dimension: status_id {
    type: number
    sql: ${TABLE}.status_id ;;
  }

  dimension: subject_id {
    type: number
    sql: ${TABLE}.subject_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
