- explore: keyword_keyword
  hidden: true
  joins:
  - join: keyword1 
    from: keyword
    foreign_key: keyword1_id
  - join: keyword2
    from: keyword
    foreign_key: keyword2_id

- view: keyword_keyword
  derived_table:
    sortkeys: [keyword1_id]
    persist_for: 100 hours
    sql: |
      SELECT
        ROW_NUMBER() OVER(ORDER BY mk1.keyword_id ) as id
        , mk1.keyword_id as keyword1_id 
        , mk2.keyword_id as keyword2_id
        , COUNT(DISTINCT mk1.movie_id) as num_movies
      FROM movie_keyword mk1
      LEFT JOIN movie_keyword mk2 ON mk1.movie_id = mk2.movie_id
      GROUP BY 2,3
      
  fields:
  - dimension: id
    primary_key: true
    
  - dimension: keyword1_id
  - dimension: keyword2_id
  
  - dimension: num_movies
  
  - measure: average_num_movies
    type: average
    sql: ${num_movies}
 
 
- explore: likely_porn_words
  hidden: true
  joins:
  - join: keyword
    from: keyword
    foreign_key: keyword_id
    
- view: likely_porn_words
  derived_table: 
    persist_for: 100 hours
    sortkeys: [keyword_id]
    sql: |
      SELECT
        keyword2_id as keyword_id
      FROM ${keyword_keyword.SQL_TABLE_NAME} as kk
      LEFT JOIN keyword ON kk.keyword1_id = keyword.id
      WHERE
        keyword.keyword = 'hardcore'
        AND num_movies > 30
        
  fields:
  - dimension: keyword_id
  
- view: movie_pornwords
  derived_table:
    persist_for: 100 hours
    sortkeys: [movie_id]
    sql: |
      SELECT
        movie_id
        , COUNT(DISTINCT mk.keyword_id) as num_keywords
        , COUNT(DISTINCT lpw.keyword_id) as num_porn_keywords
      FROM movie_keyword as mk
      LEFT JOIN ${likely_porn_words.SQL_TABLE_NAME} as lpw ON mk.keyword_id = lpw.keyword_id
      GROUP BY 1
  fields:
  - dimension: movie_id
    primary_key: true
  - dimension: num_keywords
    type: number
  - dimension: num_porn_keywords
    type: number
  - dimension: percent_pornwords
    type: number
    decimals: 2
    sql: 100.0 * ${num_porn_keywords} / ${num_keywords}
    