- view: title
  sql_table_name: public.title
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id

  - dimension: episode_nr
    type: int
    sql: ${TABLE}.episode_nr

  - dimension: episode_of_id
    type: int
    sql: ${TABLE}.episode_of_id

  - dimension: imdb_id
    type: int
    sql: ${TABLE}.imdb_id

  - dimension: imdb_index
    sql: ${TABLE}.imdb_index

  - dimension: kind_id
    type: int
    sql: ${TABLE}.kind_id
    
  - dimension: kind
    sql_case:
      Movie: ${kind_id} = 1
      TV Show: ${kind_id} = 2
      TV Movie: ${kind_id} = 3
      Video: ${kind_id} = 4
      Video Game: ${kind_id} = 6
      TV Mini Series: ${kind_id} = 7
      Unknown: true

  - dimension: md5sum
    sql: ${TABLE}.md5sum

  - dimension: phonetic_code
    sql: ${TABLE}.phonetic_code

  - dimension: production_year
    type: int
    sql: ${TABLE}.production_year

  - dimension: season_nr
    type: int
    sql: ${TABLE}.season_nr

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

