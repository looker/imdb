- view: title_location
  derived_table:
    persist_for: 100 hours
    indexes: [movie_id]
    sql: |
      SELECT 
        movie_id
        , movie_info.info AS creation_location_full
        , TRIM(REGEXP_SUBSTR(movie_info.info,'[A-z\\s]+$')) as creation_location_country
      FROM imdb.movie_info
      WHERE movie_info.info_type_id = 18
      
  fields:
  - dimension: movie_id
    hidden: true
    
  - dimension: creation_location_full
  - dimension: creation_location_country
  