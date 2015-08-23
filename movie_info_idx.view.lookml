- view: movie_info_idx
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: info
    sql: ${TABLE}.info

  - dimension: info_type_id
    type: int
    sql: ${TABLE}.info_type_id

  - dimension: movie_id
    type: int
    sql: ${TABLE}.movie_id

  - dimension: note
    sql: ${TABLE}.note

  - measure: count
    type: count
    drill_fields: [id]

