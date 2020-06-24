view: char_name {
  sql_table_name: lookerdata.imdb.char_name ;;
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
    hidden: yes
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

  dimension: md5sum {
    sql: ${TABLE}.md5sum ;;
    hidden: yes
  }

  dimension: character_name {
    sql: ${TABLE}.name ;;
  }

  dimension: name_pcode_nf {
    sql: ${TABLE}.name_pcode_nf ;;
    hidden: yes
  }

  dimension: surname_pcode {
    sql: ${TABLE}.surname_pcode ;;
    hidden: yes
  }

  measure: character_count {
    type: count
    drill_fields: [id, character_name]
  }
}
