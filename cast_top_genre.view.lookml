- view: cast_top_genre
  derived_table:
    persist_for: 100 hours
    indexes: [person_id]
    sql: |
      SELECT
        person_id
        , genre as top_genre
      FROM (
        SELECT
          cast_info.person_id as person_id
          , genre.genre as genre
          , COUNT(*) AS num_titles
          , ROW_NUMBER() OVER(PARTITION BY person_id ORDER BY num_titles DESC) as genre_rank
        FROM title 
        LEFT JOIN cast_info AS cast_info ON title.id = cast_info.movie_id
        LEFT JOIN ${movie_genre.SQL_TABLE_NAME} AS genre ON title.id = genre.movie_id
        GROUP BY 1,2
      ) AS BOO
      WHERE genre_rank = 1
  fields:
  - dimension: person_id
    hidden: true
    primary_key: true
    
  - dimension: top_genre