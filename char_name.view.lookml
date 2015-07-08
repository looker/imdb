- view: char_name
  sql_table_name: public.char_name
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: imdb_id
    type: int
    sql: ${TABLE}.imdb_id

  - dimension: imdb_index
    sql: ${TABLE}.imdb_index

  - dimension: md5sum
    sql: ${TABLE}.md5sum

  - dimension: name
    sql: ${TABLE}.name

  - dimension: name_pcode_nf
    sql: ${TABLE}.name_pcode_nf

  - dimension: surname_pcode
    sql: ${TABLE}.surname_pcode

  - measure: count
    type: count
    drill_fields: [id, name]

