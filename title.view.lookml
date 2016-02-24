- view: title
  extends: title_base
  fields:

  - dimension: episode_number
    view_label: TV Episode
    type: number
    sql: ${TABLE}.episode_nr
    #hidden: true
    
  - dimension: episode_of_id
    type: number
    sql: ${TABLE}.episode_of_id
    #hidden: true
    
  - dimension: kind_of_title
    sql_case:
      Movie: ${kind_id} = 1
      TV Show: ${kind_id} = 2
      TV Movie: ${kind_id} = 3
      Video: ${kind_id} = 4
      Video Game: ${kind_id} = 6
      TV Episode: ${kind_id} = 7
      Other: true

  - dimension: is_box_office_movie
    type: yesno
    sql: ${kind_id} = 1 AND ${movie_revenue.revenue} > 0

  - dimension: md5sum
    sql: ${TABLE}.md5sum
    hidden: true
    
  - dimension: phonetic_code
    sql: ${TABLE}.phonetic_code
    hidden: true
    
  - dimension: season_number
    view_label: TV Episode
    type: number
    sql: ${TABLE}.season_nr
    #hidden: true
    
  - dimension: title
    sql: ${TABLE}.title
    html: |
      {{ linked_value }} [<a href="https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=site:imdb.com+%22{{value}}+({{production_year._value}})%22">&#x2139;</a>]

  - measure: count
    type: count
    drill_fields: [id, kind_of_title, title, production_year]

  - measure: tv_episode_count
    view_label: TV Episode
    label: Count
    type: count
    filters:
      kind_of_title: TV Episode
    drill_fields: [tv_series.title, tv_series.series_years, id, title, production_year]

  - measure: producton_year_count
    type: count_distinct
    sql: ${production_year}
    drill_fields: [production_year, title.count]

  - measure: producton_year_first
    type: min
    sql: ${production_year}

  - measure: producton_year_last
    type: max
    sql: ${production_year}

 
    

    