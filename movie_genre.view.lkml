view: movie_genre {
  derived_table: {
    persist_for: "100 hours"
    sql: SELECT
        movie_id
        , info AS genre
      FROM lookerdata.imdb.movie_info
      WHERE info_type_id = 3
       ;;
  }

  dimension: movie_id {
    hidden: yes
  }

  dimension: genre {}
}

#   - measure: genre_list
#     type: list
#     list_field: genre
