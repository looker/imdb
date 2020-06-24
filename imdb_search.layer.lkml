#
# Unfied Single Filter
#

include: "imdb_bigquery.model"
include: "//search_block/lib/search.block"
include: "//search_block/lib/search_bigquery.block"

explore: +title_base {
  extends: [search_explore]
}

view: +title_base {
  extends: [search_view]
  filter: search {
    suggest_explore: title_base_search
  }
}


# the explore to build suggestions from...
explore: build_suggest {
  extends: [title_base]
  from: title_base
  view_name: title_base
  hidden: yes
}


explore: title_base_search {
  extends: [search_suggest]
}


view: +search_map {
  dimension: map {
    hidden: yes
    sql:
      [
        STRUCT('title.kind_of_title' as search_field, ${title.kind_of_title} as search_value),
        STRUCT('name.person_name', ${name.person_name}),
        STRUCT('char_name.character_name', ${char_name.character_name}),
        STRUCT('company_name.company_name', ${company_name.company_name}),
        STRUCT('movie_genre.genre', ${movie_genre.genre}),
        STRUCT('movie_keyword.keyword', ${movie_keyword.keyword}),
        STRUCT('tv_series.tv_series_title', ${tv_series.tv_series_title}),
        STRUCT('cast_info.role', ${cast_info.role})
      ]
    ;;
  }
  #dimension: search_primary_key {sql: ${title_base.id2} ;; }
  #dimension: search_date {sql: DATE_TRUNC(${title_base.production_year}, MONTH) ;; }
  measure: search_weight {
    label: "Title Count"
    type: count_distinct
    sql: ${title.id} ;;
    drill_fields: [title.id, title.title, title.production_year]
  }
}

view: +search_suggest {
  dimension: search_date {type:date_month}
}
