- explore: us_boxoffice
  hidden: true
  joins:
  - join: title
    sql_on: ${us_boxoffice.movie_id} = ${title.id}

#
# Boxoffice data is stored as type 107.  The records we are interested in look like:
#  $99,999 (USA) 10 November 2012
#
# There is a number for each weekend.
# 
- view: us_boxoffice
  derived_table:
    persist_for: 100 hours
    sortkeys: [movie_id]
    sql: |
      SELECT 
        * 
        , ROW_NUMBER() OVER(ORDER BY movie_id, weekend_date) as id
        , ROW_NUMBER() OVER(PARTITION BY movie_id ORDER BY weekend_date) as weekend_number
      FROM (
        SELECT 
          movie_id
          , CAST(REPLACE(REPLACE(SPLIT_PART(info,' ',1),'$',''),',','') AS NUMERIC) as weekend_amount
          , info as info
          , TO_DATE(RTRIM(REGEXP_SUBSTR(info,'[^\(]*$'),1),'DD Month YYYY') as weekend_date
         
        FROM public.movie_info AS movie_info
        WHERE 
          movie_info.info_type_id = 107
          AND info ILIKE '$%(USA)%(%)' and info ~ '\\d\\d [A-Z][a-z]* \\d\\d\\d\\d\\\)$'
      ) AS BOO
      
  fields:
  - dimension: id
    hidden: true
    primary_key: true

  - dimension: movie_id
    hidden: true
    
  - dimension: weekend_amount
    type: number
    
  - dimension: info
  
  - dimension: weekend_date
    type: date

  - dimension: weekend_number
    type: number
    
  - measure: total_amount
    type: sum
    sql: ${weekend_amount}
    
  - measure: average_amount
    type: average
    sql: ${weekend_amount}