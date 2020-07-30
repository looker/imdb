view: aka_title {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: episode_nr {
    type: number
    sql: ${TABLE}.episode_nr ;;
  }

  dimension: episode_of_id {
    type: number
    sql: ${TABLE}.episode_of_id ;;
  }

  dimension: imdb_index {
    sql: ${TABLE}.imdb_index ;;
  }

  dimension: kind_id {
    type: number
    sql: ${TABLE}.kind_id ;;
  }

  dimension: md5sum {
    sql: ${TABLE}.md5sum ;;
  }

  dimension: movie_id {
    type: number
    sql: ${TABLE}.movie_id ;;
  }

  dimension: note {
    sql: ${TABLE}.note ;;
  }

  dimension: phonetic_code {
    sql: ${TABLE}.phonetic_code ;;
  }

  dimension: production_year {
    type: number
    sql: ${TABLE}.production_year ;;
  }

  dimension: season_nr {
    type: number
    sql: ${TABLE}.season_nr ;;
  }

  dimension: title {
    sql: ${TABLE}.title ;;
  }

  measure: count {
    type: count
    drill_fields: [id]
  }
}
