- view: movie_keyword
  sql_table_name: public.movie_keyword
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: keyword_id
    type: int
    # hidden: true
    sql: ${TABLE}.keyword_id

  - dimension: movie_id
    type: int
    sql: ${TABLE}.movie_id

  - measure: count
    type: count
    drill_fields: [id, keyword.id]

