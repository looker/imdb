# Redshift implementation of IMDB

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

#     - join: movie_companies
#       sql_on: ${title.id} = ${movie_companies.movie_id}
#       relationship: one_to_many
#       
#     - join: company
#       view_label: Production Company
#       sql_on: ${movie_companies.company_id} = ${company.id}
#       relationship: many_to_one
# 
#     - join: movie_companies2
#       from: movie_companies
#       sql_on: ${title.id} = ${movie_companies2.movie_id}
#       relationship: one_to_many
#       
#     - join: company_2
#       from: company
#       view_label: Production Company (also in Title)
#       sql_on: ${movie_companies2.company_id} = ${company_2.id}
#       relationship: many_to_one
# 
# 
#     - join: movie_keyword
#       view_label: Title Keyword
#       sql_on: ${title.id} = ${movie_keyword.movie_id}
#       relationship: one_to_many
# 
# #     - join: movie_has_keyword
# #       view_label: Title Keyword
# #       sql_on: ${title.id} = ${movie_has_keyword.movie_id}
# #       relationship: one_to_many
# 
#     - join: movie_keyword_2
#       view_label: Title Keyword (also in Title)
#       from: movie_keyword
#       sql_on: ${title.id} = ${movie_keyword_2.movie_id}
#       relationship: one_to_many
# 
#     - join: movie_genre
#       view_label: Title Genre
#       sql_on: ${title.id} = ${movie_genre.movie_id}
#       relationship: one_to_many
#       
# #     - join: movie_is_genre
# #       view_label: Title Genre
# #       sql_on: ${title.id} = ${movie_is_genre.movie_id}
# #       relationship: one_to_many
# 
#     - join: movie_genre2
#       view_label: Title Genre (also in Title)
#       from: movie_genre
#       sql_on: ${title.id} = ${movie_genre2.movie_id}
#       relationship: one_to_many
#       
#     - join: movie_language
#       view_label: Title Has Language
#       sql_on: ${title.id} = ${movie_language.movie_id}
#       relationship: one_to_many
# 
#     - join: movie_language2
#       view_label: Title Has Language (also in Title)
#       from: movie_language
#       sql_on: ${title.id} = ${movie_language2.movie_id}
#       relationship: one_to_many
# 
#     - join: movie_color
#       view_label: Title
#       sql_on: ${title.id} = ${movie_color.movie_id}
#       relationship: one_to_many
#       
#     - join: movie_country_rating
#       view_label: Title Rating
#       sql_on: ${title.id} = ${movie_country_rating.movie_id}
#       relationship: one_to_many
#       
#     - join: movie_country_rating2
#       view_label: Title Rating (also in Title)
#       from: movie_country_rating
#       sql_on: ${title.id} = ${movie_country_rating2.movie_id}
#       relationship: one_to_many
#       
#     - join: movie_weekend_revenue
#       sql_on: ${title.id} = ${movie_weekend_revenue.movie_id}
#       relationship: one_to_many
# 
#     - join: movie_release_dates
#       view_label: Title Release Dates
#       sql_on: ${title.id} = ${movie_release_dates.movie_id}
#       relationship: one_to_many
#       
#     - join: movie_release_facts
#       sql_on: ${title.id} = ${movie_release_facts.movie_id}
#       relationship: many_to_one
#       view_label: Title
#       
#     - join: movie_budget
#       sql_on: ${title.id} = ${movie_budget.movie_id}
#       relationship: many_to_one
#       view_label: Title
#       
#     - join: title_location
#       sql_on: ${title.id} = ${title_location.movie_id}
#       relationship: one_to_many
#       view_label: Title
# 
#     - join: title_extra
#       view_label: Title
#       
#     - join: tv_series
#       view_label: TV Episode
#       sql_on: ${title.episode_of_id} = ${tv_series.id}
#       relationship: many_to_one
#   