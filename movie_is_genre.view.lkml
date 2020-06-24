view: movie_is_genre {
  derived_table: {
    sql: select
        movie_id
        , genre
      FROM ${movie_genre.SQL_TABLE_NAME} AS mg
      WHERE
        {% condition select %} mg.genre {% endcondition %}
       ;;
  }

  dimension: movie_id {
    hidden: yes
  }

  filter: select {
    suggest_dimension: movie_genre.genre
  }

  dimension: genre_select_is_genre {
    type: yesno
    sql: ${movie_id} IS NOT NULL ;;
  }
}
