- explore: movie_weekend_revenue
  extends: title_simple
  hidden: true
  joins:
  - join: title
    sql_on: ${movie_weekend_revenue.movie_id} = ${title.id}
    relationship: many_to_one

#
# Boxoffice data is stored as type 107.  The records we are interested in look like:
#  $99,999 (USA) 10 November 2012
#
# There is a number for each weekend.
# 
- view: movie_weekend_revenue
  derived_table:
    persist_for: 100 hours
    sortkeys: [movie_id]
    sql: |
      SELECT 
        * 
        , ROW_NUMBER() OVER(ORDER BY movie_id, weekend_date) as id
        , ROW_NUMBER() OVER(PARTITION BY movie_id ORDER BY weekend_date) as weekend_number
        , amount_to_date - COALESCE(LAG(amount_to_date) OVER (PARTITION BY movie_id ORDER BY weekend_date),0) as weekend_amount
      FROM (
        SELECT 
          movie_id
          , CAST(REPLACE(REPLACE(SPLIT_PART(info,' ',1),'$',''),',','') AS NUMERIC) / 1000000.0 as amount_to_date 
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
    value_format: '$#,##0.00 \M'
    
  - dimension: info
  
  - dimension: weekend_date
    type: date

  - dimension: weekend_number
    type: number
    
  - measure: total_amount
    type: sum
    sql: ${weekend_amount}
    value_format: '$#,##0.00 \M'
    
  - measure: average_amount
    type: average
    sql: ${weekend_amount}
    value_format: '$#,##0.00 \M'
    
- view: movie_revenue
  derived_table:
    persist_for: 100 hours
    sortkeys: [movie_id]
    sql: |
      SELECT 
        movie_id
        , CAST(MAX(world_wide_rev) AS NUMERIC) / 1000000 as world_wide_revenue
        , CAST(MAX(usa_rev) AS NUMERIC) / 1000000 as usa_revenue
      FROM (
        SELECT 
          movie_id
          , CASE WHEN info ~ '\\$[\\d\\,]* \\(Worldwide\\)$'
              THEN REPLACE(REGEXP_SUBSTR(info,'[\\d\\,]+'),',','')
              ELSE NULL
            END AS world_wide_rev
          , CASE WHEN info ~ '\\$[\\d\\,]* \\(USA\\)$'
              THEN REPLACE(REGEXP_SUBSTR(info,'[\\d\\,]+'),',','')
              ELSE NULL
            END AS usa_rev
            
        FROM public.movie_info AS movie_info
        WHERE 
          movie_info.info_type_id = 107
      ) AS BOO
      GROUP BY 1
      HAVING MAX(world_wide_rev) IS NOT NULL OR MAX(usa_rev) IS NOT NULL
    
  fields:
  - dimension: movie_id
    primary_key: true
    hidden: true
    
  - dimension: world_wide_revenue
    type: number
    value_format: '$#,##0.00 \M'
  
  - dimension: usa_revenue
    type: number
    value_format: '$#,##0.00 \M'
    
  - dimension: revenue
    type: number
    sql: COALESCE(${world_wide_revenue}, ${usa_revenue})
    value_format: '$#,##0.00 \M'
    
  - measure: total_revenue
    type: sum
    sql: ${revenue}
    value_format: '$#,##0.00 \M'
    
