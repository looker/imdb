
- explore: movie_release_dates
  extends: title_simple
  hidden: true
  joins:
  - join: title
    sql_on: ${movie_release_dates.movie_id} = ${title.id}
    relationship: many_to_one

- view: movie_release_dates
  derived_table:
    persist_for: 100 hours
    sortkeys: [movie_id]
    sql: |
      SELECT 
        * 
        , ROW_NUMBER() OVER(ORDER BY movie_id, release_date) as id
        , RANK() OVER(PARTITION BY movie_id ORDER BY release_date) as index
      FROM (
        SELECT 
          movie_id
          , SPLIT_PART(info,':',1) as country
          , note as kind
          , SPLIT_PART(info,':',2) as date_string
          , CASE 
              WHEN SPLIT_PART(info,':',2) ~ '^\\d\\d [A-Za-z]+ \\d\\d\\d\\d$'
                THEN TO_DATE( SPLIT_PART(info,':',2), 'DD Month YYYY')
              WHEN SPLIT_PART(info,':',2) ~ '^[A-Za-z]+ \\d\\d\\d\\d$'
                THEN TO_DATE( SPLIT_PART(info,':',2), 'Month YYYY')
              WHEN SPLIT_PART(info,':',2) ~ '^\\d\\d\\d\\d$'
                THEN TO_DATE( SPLIT_PART(info,':',2), 'YYYY')
              ELSE NULL
            END as release_date
        FROM movie_info
        WHERE 
          movie_info.info_type_id = 16
      ) AS BOO
      WHERE release_date IS NOT NULL
      
  fields:
  - dimension: id
    hidden: true
    primary_key: true

  - dimension: movie_id
    hidden: true
    
  - dimension: country

  - dimension: date_string

  - dimension: release
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.release_date

  - dimension: kind
  
  - dimension: index
    type: number
    
  - measure: count
    type: count
    drill_fields: [id, title.title, title.id, country, release_date, index, kind]


#  Fact table about releases, one per title.

- explore: movie_release_facts
  extends: title_simple
  hidden: true
  joins:
  - join: title
    sql_on: ${movie_release_facts.movie_id} = ${title.id}
    relationship: many_to_one

- view: movie_release_facts
  derived_table:
    persist_for: 100 hours
    sortkeys: [movie_id]
    sql: |
      SELECT
        movie_id
        , MIN(release_date) as first_release_date
        , MAX(release_date) as last_release_date
        , COUNT(DISTINCT CASE WHEN index = 1 THEN country ELSE NULL END) simultaneous_countries
        , COUNT(DISTINCT CASE WHEN index = 1 and country = 'USA' THEN 1 ELSE NULL END) usa_premiere
      FROM ${movie_release_dates.SQL_TABLE_NAME} as mrd
      GROUP BY 1
  
  fields:
  - dimension: movie_id
    hidden: true
    primary_key: true
    
  - dimension: first_release
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.first_release_date
    
  - dimension: last_release
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.last_release_date
  
  - dimension: simultaneous_countries
    type: number
    
  - dimension: usa_premiere
    label: Had USA Premiere
    type: yesno
    sql: ${TABLE}.usa_premiere = 1
    
    
    
    