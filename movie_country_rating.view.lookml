- view: movie_country_rating
  derived_table:
    persist_for: 100 hours
    indexes: [movie_id]
    sql: |
      SELECT 
        movie_id
        , SPLIT_PART(movie_info.info,':', 1) AS country
        , SPLIT_PART(movie_info.info,':', 2) AS rating
        , movie_info.info AS country_rating
      FROM imdb.movie_info AS movie_info
      WHERE movie_info.info_type_id = 5
      
  fields:
  - dimension: movie_id
    hidden: true
  - dimension: country
  - dimension: rating
  - dimension: country_rating