#  Fact table about releases, one per title.
view: movie_release_facts {
  derived_table: {
    persist_for: "100 hours"
    sql: SELECT
        movie_id
        , MIN(release_date) as first_release_date
        , MAX(release_date) as last_release_date
        , COUNT(DISTINCT CASE WHEN index = 1 THEN country ELSE NULL END) simultaneous_countries
        , COUNT(DISTINCT CASE WHEN index = 1 and country = 'USA' THEN 1 ELSE NULL END) usa_premiere
      FROM ${movie_release_dates.SQL_TABLE_NAME} as mrd
      GROUP BY movie_id
       ;;
  }

  dimension: movie_id {
    hidden: yes
    primary_key: yes
  }

  dimension_group: first_release {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.first_release_date ;;
  }

  dimension_group: last_release {
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.last_release_date ;;
  }

  dimension: simultaneous_countries {
    type: number
  }

  dimension: usa_premiere {
    label: "Had USA Premiere"
    type: yesno
    sql: ${TABLE}.usa_premiere = 1 ;;
  }
}
