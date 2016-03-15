- connection: lookerdata_publicdata
- label: 'IMDB'

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- include: imdb.base.lookml

- case_sensitive: false  

- view: title_table_name
  sql_table_name: imdb.title

- explore: title    
  extends: title_base
  hidden: false
  joins:
    - join: cast_info
      type: left_outer_each
    - join: char_name
      type: left_outer_each
    - join: name
      type: left_outer_each
    - join: cast_title_facts
      type: left_outer_each
    - join: cast_top_genre
      type: left_outer_each
    - join: cast_info2
      type: left_outer_each
    - join: char_name2
      type: left_outer_each
    - join: name2
      type: left_outer_each
    - join: tv_series
      type: left_outer_each
    - join: movie_genre
      type: left_outer_each
