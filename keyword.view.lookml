- view: keyword
  sql_table_name: keyword
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id

  - dimension: keyword
    sql: ${TABLE}.keyword

  - dimension: phonetic_code
    sql: ${TABLE}.phonetic_code

  - measure: count
    type: count
    drill_fields: [id, movie_keyword.count]