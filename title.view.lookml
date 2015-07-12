- view: title_base
  sql_table_name: public.title
  fields:
  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id
  
  - dimension: imdb_id
    type: int
    sql: ${TABLE}.imdb_id
    hidden: true
    
  - dimension: imdb_index
    sql: ${TABLE}.imdb_index
    hidden: true
    
  - dimension: kind_id
    type: int
    sql: ${TABLE}.kind_id
    hidden: true

  - dimension: title
    sql: ${TABLE}.title

  - dimension: production_year
    type: int
    sql: ${TABLE}.production_year

  - measure: count
    type: count
    drill_fields: [id, title, production_year]


- view: title
  extends: title_base
  fields:

  - dimension: episode_number
    view_label: TV Episode
    type: int
    sql: ${TABLE}.episode_nr
    #hidden: true
    
  - dimension: episode_of_id
    type: int
    sql: ${TABLE}.episode_of_id
    #hidden: true
    
  - dimension: kind
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
    type: int
    sql: ${TABLE}.season_nr
    #hidden: true
    
  - dimension: title
    sql: ${TABLE}.title
    html: |
      {{ linked_value }} [<a href="https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=site:imdb.com+%22{{value}}+({{production_year._value}})%22">&#x2139;</a>]

  - measure: count
    type: count
    drill_fields: [id, title, production_year, kind]

  - measure: tv_episode_count
    view_label: TV Episode
    label: Count
    type: count
    filters:
      kind: TV Episode
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

 
    
- view: tv_series
  extends: title_base
  fields:
  - dimension: series_years
    sql: ${TABLE}.series_years
    
  - dimension: title
    html: |
      {{ linked_value }} [<a href="https://www.google.com/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=site:imdb.com+%22{{value}}+({{production_year._value}})%22">&#x2139;</a>]
  
  - dimension: series_years
    sql: ${TABLE}.series_years
    

    
- view: title_extra
  fields:
  - measure: revenue_over_budget
    type: number
    sql: ${movie_revenue.total_revenue} / ${movie_budget.total_budget}
    decimals: 4

#   - dimension: opening_weekend_amount_tiered
#     type: tier
#     tiers: [1,5,10,20,50,100,250,500]
#     sql: ${movie_weekend_revenue.weekend_amount}
# 
