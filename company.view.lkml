view: company_name {
  sql_table_name: lookerdata.imdb.company_name ;;
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: country_code {
    sql: ${TABLE}.country_code ;;
  }

  dimension: imdb_id {
    type: number
    sql: ${TABLE}.imdb_id ;;
    hidden: yes
  }

  dimension: md5sum {
    sql: ${TABLE}.md5sum ;;
    hidden: yes
  }

  dimension: company_name {
    sql: ${TABLE}.name ;;
  }

  dimension: name_pcode_nf {
    sql: ${TABLE}.name_pcode_nf ;;
    hidden: yes
  }

  dimension: name_pcode_sf {
    sql: ${TABLE}.name_pcode_sf ;;
    hidden: yes
  }

  measure: count {
    type: count
    drill_fields: [id, company_name]
  }
}
