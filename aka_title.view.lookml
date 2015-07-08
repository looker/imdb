- view: aka_title
  sql_table_name: public.aka_title
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: episode_nr
    type: int
    sql: ${TABLE}.episode_nr

  - dimension: episode_of_id
    type: int
    sql: ${TABLE}.episode_of_id

  - dimension: imdb_index
    sql: ${TABLE}.imdb_index

  - dimension: kind_id
    type: int
    sql: ${TABLE}.kind_id

  - dimension: md5sum
    sql: ${TABLE}.md5sum

  - dimension: movie_id
    type: int
    sql: ${TABLE}.movie_id

  - dimension: note
    sql: ${TABLE}.note

  - dimension: phonetic_code
    sql: ${TABLE}.phonetic_code

  - dimension: production_year
    type: int
    sql: ${TABLE}.production_year

  - dimension: season_nr
    type: int
    sql: ${TABLE}.season_nr

  - dimension: title
    sql: ${TABLE}.title

  - measure: count
    type: count
    drill_fields: [id]

