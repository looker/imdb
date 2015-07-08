- view: movie_genre
  derived_table:
    persist_for: 100 hours
    sortkeys: [movie_id]
    sql: |
      SELECT 
        movie_id
        , movie_info.info AS genre
      FROM public.movie_info AS movie_info
      WHERE movie_info.info_type_id = 3
      
  fields:
  - dimension: movie_id
    hidden: true
  - dimension: genre
  - measure: genre_list
    type: list
    list_field: genre
