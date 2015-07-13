- connection: imdb

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards
- case_sensitive: false

- explore: title
  view: title
  sql_always_where: ${title.kind_id} <> 2 
  extends: title_simple
  joins:
    - join: cast_info
      view_label: Cast Member
      sql_on: ${title.id} = ${cast_info.movie_id}
      relationship: one_to_many
      
    - join: char_name
      view_label: Cast Member
      sql_on: ${char_name.id} = ${cast_info.person_role_id}
      relationship: one_to_many
      
    - join: name
      view_label: Cast Member
      sql_on: ${cast_info.person_id} = ${name.id}
      relationship: many_to_one
      
    - join: cast_title_facts
      view_label: Cast Member
      sql_on: ${cast_info.person_id} = ${cast_title_facts.person_id}
      relationship: many_to_one

    - join: cast_top_genre
      view_label: Cast Member
      sql_on: ${cast_info.person_id} = ${cast_top_genre.person_id}
      relationship: many_to_one
      
    - join: cast_info2
      view_label: Cast Member 2
      from: cast_info
      sql_on: ${title.id} = ${cast_info2.movie_id}
      relationship: one_to_many
      
    - join: char_name2
      view_label: Cast Member 2
      from: char_name
      sql_on: ${char_name2.id} = ${cast_info2.person_role_id}
      relationship: one_to_many
    - join: name2
    
      view_label: Cast Member 2
      from: name
      sql_on: ${cast_info2.person_id} = ${name2.id}
      relationship: many_to_one

    - join: movie_companies
      sql_on: ${title.id} = ${movie_companies.movie_id}
      relationship: one_to_many
      
    - join: company
      view_label: Production Company
      sql_on: ${movie_companies.company_id} = ${company.id}
      relationship: many_to_one

    - join: movie_companies2
      from: movie_companies
      sql_on: ${title.id} = ${movie_companies2.movie_id}
      relationship: one_to_many
      
    - join: company_2
      from: company
      view_label: Production Company 2
      sql_on: ${movie_companies2.company_id} = ${company_2.id}
      relationship: many_to_one


    - join: movie_keyword
      view_label: Title Keyword
      sql_on: ${title.id} = ${movie_keyword.movie_id}
      relationship: one_to_many

    - join: movie_has_keyword
      view_label: Title Keyword
      sql_on: ${title.id} = ${movie_has_keyword.movie_id}
      relationship: one_to_many

    - join: movie_keyword_2
      view_label: Title Keyword 2
      from: movie_keyword
      sql_on: ${title.id} = ${movie_keyword_2.movie_id}
      relationship: one_to_many

    - join: movie_genre
      view_label: Title Genre
      sql_on: ${title.id} = ${movie_genre.movie_id}
      relationship: one_to_many
      
    - join: movie_is_genre
      view_label: Title Genre
      sql_on: ${title.id} = ${movie_is_genre.movie_id}
      relationship: one_to_many

    - join: movie_genre2
      view_label: Title Genre 2
      from: movie_genre
      sql_on: ${title.id} = ${movie_genre2.movie_id}
      relationship: one_to_many
      
    - join: movie_language
      view_label: Title Has Language
      sql_on: ${title.id} = ${movie_language.movie_id}
      relationship: one_to_many

    - join: movie_language2
      view_label: Title Has Language 2
      from: movie_language
      sql_on: ${title.id} = ${movie_language2.movie_id}
      relationship: one_to_many

    - join: movie_color
      sql_on: ${title.id} = ${movie_color.movie_id}
      relationship: one_to_many
      
    - join: movie_country_rating
      view_label: Title Rating
      sql_on: ${title.id} = ${movie_country_rating.movie_id}
      relationship: one_to_many
      
    - join: movie_country_rating2
      view_label: Title Rating 2
      from: movie_country_rating
      sql_on: ${title.id} = ${movie_country_rating2.movie_id}
      relationship: one_to_many
      
    - join: movie_weekend_revenue
      sql_on: ${title.id} = ${movie_weekend_revenue.movie_id}
      relationship: one_to_many

    - join: movie_release_dates
      view_label: Title Release Dates
      sql_on: ${title.id} = ${movie_release_dates.movie_id}
      relationship: one_to_many
      
    - join: movie_release_facts
      sql_on: ${title.id} = ${movie_release_facts.movie_id}
      relationship: many_to_one
      view_label: Title
      
    - join: movie_budget
      sql_on: ${title.id} = ${movie_budget.movie_id}
      relationship: many_to_one
      view_label: Title
      
    - join: title_location
      sql_on: ${title.id} = ${title_location.movie_id}
      relationship: one_to_many
      view_label: Title

    - join: title_extra
      view_label: Title
      
    - join: tv_series
      view_label: TV Episode
      sql_on: ${title.episode_of_id} = ${tv_series.id}
      relationship: many_to_one
  
      
# When joining in title, here are the joins you might want to use
- explore: title_simple
  extension: required
  joins:
    - join: movie_revenue
      sql_on: ${title.id} = ${movie_revenue.movie_id}
      relationship: many_to_one
      view_label: Title
      