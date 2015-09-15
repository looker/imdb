# Spark implementation of IMDB

- connection: spark_imdb

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- include: imdb.base.lookml

- case_sensitive: false

- explore: title
  extends: title_base
  joins:
    - join: cast_info
      type: inner
    - join: char_name
      type: inner
    - join: name
      type: inner
    - join: cast_title_facts
      type: inner
    - join: cast_top_genre
      type: inner
    - join: cast_info2
      type: inner
    - join: char_name2
      type: inner
    - join: name2
      type: inner
    - join: tv_series
      type: inner
