- view: title_location
  derived_table:
    persist_for: 100 hours
    sortkeys: [movie_id]
    sql: |
      SELECT 
        movie_id
        , movie_info.info AS creation_full_location
        , TRIM(REGEXP_SUBSTR(movie_info.info,'[A-z\\s]+$')) as creation_country_location
      FROM public.movie_info AS movie_info
      WHERE movie_info.info_type_id = 18
      
  fields:
  - dimension: movie_id
    hidden: true
    
  - dimension: creation_full_location
  - dimension: creation_country_location