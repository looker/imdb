# Redshift implementation of IMDB

- connection: spark_imdb

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- include: imdb.base.lookml

- case_sensitive: false

- explore: title
  extends: title_base
