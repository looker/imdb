- view: movie_country_rating
  derived_table:
    persist_for: 100 hours
    sortkeys: [movie_id]
    sql: |
      SELECT 
        movie_id
        , SPLIT_PART(movie_info.info,':', 1) AS country
        , movie_info.info AS country_rating
      FROM public.movie_info AS movie_info
      WHERE movie_info.info_type_id = 5
      
  fields:
  - dimension: movie_id
    hidden: true
  - dimension: country
  - dimension: country_rating
