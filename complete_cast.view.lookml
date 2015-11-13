- view: complete_cast
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: movie_id
    type: int
    sql: ${TABLE}.movie_id

  - dimension: status_id
    type: int
    sql: ${TABLE}.status_id

  - dimension: subject_id
    type: int
    sql: ${TABLE}.subject_id

  - measure: count
    type: count
    drill_fields: [id]
