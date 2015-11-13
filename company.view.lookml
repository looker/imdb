- view: company
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: country_code
    sql: ${TABLE}.country_code

  - dimension: imdb_id
    type: int
    sql: ${TABLE}.imdb_id
    hidden: true

  - dimension: md5sum
    sql: ${TABLE}.md5sum
    hidden: true

  - dimension: company_name
    sql: ${TABLE}.name

  - dimension: name_pcode_nf
    sql: ${TABLE}.name_pcode_nf
    hidden: true

  - dimension: name_pcode_sf
    sql: ${TABLE}.name_pcode_sf
    hidden: true

  - measure: count
    type: count
    drill_fields: [id, company_name]


