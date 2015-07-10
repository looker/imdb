- view: title
  sql_table_name: public.title
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id
    hidden: true

  - dimension: episode_nr
    type: int
    sql: ${TABLE}.episode_nr
    hidden: true
    
  - dimension: episode_of_id
    type: int
    sql: ${TABLE}.episode_of_id
    hidden: true
    
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
    
  - dimension: kind
    sql_case:
      Movie: ${kind_id} = 1
      TV Show: ${kind_id} = 2
      TV Movie: ${kind_id} = 3
      Video: ${kind_id} = 4
      Video Game: ${kind_id} = 6
      TV Series: ${kind_id} = 7
      All: true

  - dimension: is_box_office_movie
    type: yesno
    sql: ${kind_id} = 1 AND ${us_opening_weekend.weekend_amount} > 1

  - dimension: md5sum
    sql: ${TABLE}.md5sum
    hidden: true
    
  - dimension: phonetic_code
    sql: ${TABLE}.phonetic_code
    hidden: true
    
  - dimension: production_year
    type: int
    sql: ${TABLE}.production_year

  - dimension: season_nr
    type: int
    sql: ${TABLE}.season_nr
    hidden: true
    
  - dimension: series_years
    sql: ${TABLE}.series_years
    
  - dimension: title
    sql: ${TABLE}.title

  - measure: count
    type: count
    drill_fields: [id, title, kind, production_year]
    
  - dimension: opening_weekend_amount_tiered
    type: tier
    tiers: [1,5,10,20,50,100,250,500]
    sql: ${us_opening_weekend.weekend_amount}

