- view: char_name
  sql_table_name: char_name
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id
    hidden: true

  - dimension: imdb_id
    type: number
    sql: ${TABLE}.imdb_id
    hidden: true

  - dimension: imdb_index
    sql: ${TABLE}.imdb_index
    hidden: true

  - dimension: md5sum
    sql: ${TABLE}.md5sum
    hidden: true

  - dimension: character_name
    sql: ${TABLE}.name

  - dimension: name_pcode_nf
    sql: ${TABLE}.name_pcode_nf
    hidden: true

  - dimension: surname_pcode
    sql: ${TABLE}.surname_pcode
    hidden: true

  - measure: character_count
    type: count
    drill_fields: [id, character_name]