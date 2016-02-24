- view: movie_companies
  sql_table_name: imdb.movie_companies
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id
    hidden: true

  - dimension: company_id
    type: number
    sql: ${TABLE}.company_id
    hidden: true

  - dimension: company_type_id
    type: number
    sql: ${TABLE}.company_type_id
    hidden: true

  - dimension: movie_id
    type: number
    sql: ${TABLE}.movie_id
    hidden: true

  - dimension: note
    sql: ${TABLE}.note
    hidden: true

  - measure: count
    type: count
    drill_fields: [id]
    hidden: true