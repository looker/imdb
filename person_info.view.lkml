view: person_info {
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

  dimension: note {
    sql: ${TABLE}.note ;;
  }

  dimension: person_id {
    type: number
    sql: ${TABLE}.person_id ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
