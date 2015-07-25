- explore: top_countries_by_film_count
  extends: title
  joins:
    - join: top_countries
      sql_on: ${company.country_code} = ${top_countries.country}
      type: inner
      relationship: many_to_one
      
      
- view: top_countries
  derived_table:
    sql: |
      SELECT
        company.country_code as country
      , rank () over
        (ORDER BY count(*) DESC) as ranking
        
      FROM public.title as title
      LEFT JOIN public.movie_companies AS movie_companies ON title.id = movie_companies.movie_id
      LEFT JOIN public.company_name AS company ON movie_companies.company_id = company.id
      WHERE 
        ((company.country_code) IS NOT NULL)
      GROUP BY 1  
      


  fields:
  
  - dimension: country
    sql: ${TABLE}.country

  - dimension: ranking
    type: number
    sql: ${TABLE}.ranking
    
  - dimension: is_top
    type: yesno
    sql: ${ranking} <= 10
    
  - dimension: top
    order_by_field: min_rank
    sql: |
          CASE WHEN ${is_top} = 'yes' THEN ${country}
          ELSE 'Other' END
    
  
  - measure: min_rank
    type: min
    sql: ${ranking}
    
  - measure: count
    type: count
    drill_fields: detail*  
    


  sets:
    detail:
      - country
      - ranking
