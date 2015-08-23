- view: movie_keyword
  derived_table:
    persist_for: 100 hours
    sortkeys: [movie_id]
    sql: |
      SELECT 
        movie_id
        , keyword
        , ROW_NUMBER() OVER (order by movie_id) as id
      FROM movie_keyword AS mk
      JOIN keyword AS k ON mk.keyword_id = k.id

  fields:

  - dimension: id
    primary_key: true
    hidden: true
    type: int
    sql: ${TABLE}.id

  - dimension: keyword
  
  - dimension: movie_id
    type: int
    hidden: true
    sql: ${TABLE}.movie_id

  - measure: keyword_count
    type: count_distinct
    drill_fields: [id, keyword, title.count]

- view: movie_has_keyword
  derived_table:
    sql: |
      select
        movie_id
        , keyword
      FROM ${movie_keyword.SQL_TABLE_NAME} AS mk
      WHERE
        {% condition select %} mk.keyword {% endcondition %}
        
  fields:
  - dimension: movie_id
    hidden: true
    
  - filter: select
    suggest_dimension: movie_keyword.keyword
    
  - dimension: keyword_select_has_keyword
    type: yesno
    sql: ${movie_id} IS NOT NULL