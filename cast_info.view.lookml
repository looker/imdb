- view: cast_info
  sql_table_name: public.cast_info
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: movie_id
    type: int
    sql: ${TABLE}.movie_id

  - dimension: note
    sql: ${TABLE}.note

  - dimension: nr_order
    type: int
    sql: ${TABLE}.nr_order

  - dimension: person_id
    type: int
    sql: ${TABLE}.person_id

  - dimension: person_role_id
    type: int
    sql: ${TABLE}.person_role_id

  - dimension: role_id
    type: int
    sql: ${TABLE}.role_id

  - measure: count
    type: count
    drill_fields: [id]

