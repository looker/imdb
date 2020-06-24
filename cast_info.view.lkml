view: cast_info {
  sql_table_name: lookerdata.imdb.cast_info ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
  }

  dimension: movie_id {
    type: number
    sql: ${TABLE}.movie_id ;;
    hidden: yes
  }

  dimension: note {
    sql: ${TABLE}.note ;;
  }

  dimension: named_role_order {
    type: number
    sql: ${TABLE}.nr_order ;;
  }

  measure: average_named_role_order {
    type: average
    sql: ${named_role_order} ;;
  }

  dimension: person_id {
    type: number
    sql: ${TABLE}.person_id ;;
    hidden: yes
  }

  dimension: person_role_id {
    type: number
    sql: ${TABLE}.person_role_id ;;
    hidden: yes
  }

  dimension: role_id {
    type: number
    sql: ${TABLE}.role_id ;;
    hidden: yes
  }

  dimension: role {
    label: "Role (Job they performed)"

    case: {
      when: {
        sql: ${role_id} = 12 ;;
        label: "12"
      }

      when: {
        sql: ${role_id} IN (1, 2) ;;
        label: "Actor"
      }

      when: {
        sql: ${role_id} = 3 ;;
        label: "Producer"
      }

      when: {
        sql: ${role_id} = 4 ;;
        label: "Writer"
      }

      when: {
        sql: ${role_id} = 5 ;;
        label: "Director of Photography"
      }

      when: {
        sql: ${role_id} = 6 ;;
        label: "Conductor"
      }

      when: {
        sql: ${role_id} = 7 ;;
        label: "Costume"
      }

      when: {
        sql: ${role_id} = 8 ;;
        label: "Director"
      }

      when: {
        sql: ${role_id} = 9 ;;
        label: "Editing"
      }

      when: {
        sql: ${role_id} = 10 ;;
        label: "Other Crew"
      }

      when: {
        sql: ${role_id} = 11 ;;
        label: "Production Design"
      }
    }
  }

  measure: person_in_role_count {
    type: count
    drill_fields: [id, name.person_name, role]
  }
}
