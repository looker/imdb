- view: movie_color
  derived_table:
    persist_for: 100 hours
    indexes: [movie_id]
    sql: |
      SELECT 
        movie_id
        , movie_info.info AS color
      FROM movie_info AS movie_info
      WHERE movie_info.info_type_id = 2
      
  fields:
  - dimension: movie_id
    hidden: true
  - dimension: color
  