- view: name
  sql_table_name: public.name
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id
    hidden: true

  - dimension: gender
    sql: ${TABLE}.gender

  - dimension: imdb_id
    type: int
    sql: ${TABLE}.imdb_id
    hidden: true

  - dimension: imdb_index
    sql: ${TABLE}.imdb_index
    hidden: true

  - dimension: md5sum
    sql: ${TABLE}.md5sum
    hidden: true

  - dimension: name
    sql: ${TABLE}.name

  - dimension: name_pcode_cf
    sql: ${TABLE}.name_pcode_cf
    hidden: true

  - dimension: name_pcode_nf
    sql: ${TABLE}.name_pcode_nf
    hidden: true

  - dimension: surname_pcode
    sql: ${TABLE}.surname_pcode
    hidden: true

