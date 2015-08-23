- view: movie_companies
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id
    hidden: true

  - dimension: company_id
    type: int
    sql: ${TABLE}.company_id
    hidden: true

  - dimension: company_type_id
    type: int
    sql: ${TABLE}.company_type_id
    hidden: true

  - dimension: movie_id
    type: int
    sql: ${TABLE}.movie_id
    hidden: true

  - dimension: note
    sql: ${TABLE}.note
    hidden: true

  - measure: count
    type: count
    drill_fields: [id]
    hidden: true

