- connection: lookerdata_publicdata

# Redshift implementation of IMDB
#  
# - connection: imdb
# 
# - include: "*.view.lookml"       # include all the views
# - include: "*.dashboard.lookml"  # include all the dashboards
# 
# - include: imdb.base.lookml
# 
# - case_sensitive: false
# 
# - explore: title
#   extends: title_base
#   hidden: true
#   # Redshift doesn't support lists, remove the fields.
#   fields: [ALL_FIELDS*, -movie_genre.genre_list, -movie_genre2.genre_list]
