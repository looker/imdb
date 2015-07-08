- view: movie_link
  sql_table_name: public.movie_link
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: link_type_id
    type: int
    sql: ${TABLE}.link_type_id

  - dimension: linked_movie_id
    type: int
    sql: ${TABLE}.linked_movie_id

  - dimension: movie_id
    type: int
    sql: ${TABLE}.movie_id

  - measure: count
    type: count
    drill_fields: [id]

