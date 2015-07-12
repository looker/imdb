- view: cast_title_facts
  derived_table:
    persist_for: 100 hours
    sortkeys: [person_id]
    sql: |
      SELECT
        cast_info.person_id as person_id
        , name.name AS name
        , COUNT(DISTINCT title.id) AS lifetime_titles
        , MIN(title.production_year) AS first_production_year
        , MAX(title.production_year) AS last_production_year
        , COUNT(DISTINCT title.production_year) AS years_with_titles
        , COUNT(DISTINCT CASE WHEN cast_info.role_id IN (1,2) THEN title.production_year ELSE NULL END) AS years_acted
      FROM public.title AS title
      LEFT JOIN public.cast_info AS cast_info ON title.id = cast_info.movie_id
      LEFT JOIN public.name AS name ON cast_info.person_id = name.id
      GROUP BY 1,2
  fields:
  - dimension: person_id
    hidden: true
    primary_key: true
    
  - dimension: lifetime_titles
    type: number
    
  - dimension: lifetime_titles_tiered
    type: tier
    tiers: [1,3,10,20,50]
    style: integer
    sql: ${lifetime_titles}
    
  - dimension: first_production_year
    type: number
    
  - dimension: last_production_year
    type: number
    
  - dimension: years_with_titles
    type: number
    description: number of different years with titles
    
  - dimension: years_worked
    type: number
    sql: ${last_production_year} - ${first_production_year} + 1
    description: Difference between first production year and last production year +1
    
  - dimension: years_acted
    type: number
    description: number of distinct production years where the role was acting