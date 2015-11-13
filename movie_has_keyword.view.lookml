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