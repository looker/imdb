- view: person_info
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

  - dimension: note
    sql: ${TABLE}.note

  - dimension: person_id
    type: int
    sql: ${TABLE}.person_id

  - measure: count
    type: count
    drill_fields: [id]

