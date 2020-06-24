view: tv_series {
  sql_table_name: `lookerdata.imdb.title` ;;

  dimension: id {
    label: "TV Series ID"
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: production_year {
    label: "TV Series Production Year"
    type: number
    sql: ${TABLE}.production_year ;;
  }

  measure: tv_series_count {
    type: count
    drill_fields: [id, tv_series_title, production_year]
  }

  dimension: tv_series_years {
    sql: ${TABLE}.series_years ;;
  }

  dimension: tv_series_title {
    sql: ${TABLE}.title ;;
    link: {
      label: "IMDB"
      url: "https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=site:imdb.com+%22{{value}}+({{production_year._value}})%22"
    }
  }
}
