- view: tv_series
  sql_table_name: title
  fields:
  - dimension: id
    label: TV Series ID
    primary_key: true
    type: int
    sql: ${TABLE}.id
  
  - dimension: production_year
    label: TV Series Production Year
    type: int
    sql: ${TABLE}.production_year

  - measure: tv_series_count
    type: count
    drill_fields: [id, tv_series_title, production_year]
    
  - dimension: tv_series_years
    sql: ${TABLE}.series_years
    
  - dimension: tv_series_title
    sql: ${TABLE}.title
    html: |
      {{ linked_value }} [<a href="https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=site:imdb.com+%22{{value}}+({{production_year._value}})%22">&#x2139;</a>]

