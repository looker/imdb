- connection: imdb-aryeh

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards


- explore: title
  view: title
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
    - join: company_name
      view_label: Company
      sql_on: ${movie_companies.company_id} = ${company_name.id}
      relationship: many_to_one

    - join: movie_keyword
      sql_on: ${title.id} = ${movie_keyword.movie_id}
      relationship: one_to_many

    - join: keyword
      sql_on: ${movie_keyword.keyword_id} = ${keyword.id}
      relationship: many_to_one

    - join: movie_keyword2
      from: movie_keyword
      sql_on: ${title.id} = ${movie_keyword2.movie_id}
      relationship: one_to_many

    - join: keyword2
      from: keyword
      sql_on: ${movie_keyword2.keyword_id} = ${keyword2.id}
      relationship: many_to_one


    - join: movie_genre
      sql_on: ${title.id} = ${movie_genre.movie_id}
      relationship: one_to_many

    - join: movie_genre2
      from: movie_genre
      sql_on: ${title.id} = ${movie_genre2.movie_id}
      relationship: one_to_many
      
    - join: movie_language
      sql_on: ${title.id} = ${movie_language.movie_id}
      relationship: one_to_many

    - join: movie_language2
      from: movie_language
      sql_on: ${title.id} = ${movie_language2.movie_id}
      relationship: one_to_many

    - join: movie_color
      sql_on: ${title.id} = ${movie_color.movie_id}
      relationship: one_to_many
    - join: movie_country_rating
      sql_on: ${title.id} = ${movie_country_rating.movie_id}
      relationship: one_to_many
    - join: movie_country_rating2
      from: movie_country_rating
      sql_on: ${title.id} = ${movie_country_rating2.movie_id}
      relationship: one_to_many
      
    - join: us_boxoffice
      sql_on: ${title.id} = ${us_boxoffice.movie_id}
      relationship: one_to_many

    - join: movie_release_dates
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
      
- explore: boxoffice_movie
  extends: title
  always_filter:
    title.is_box_office_movie: Yes

# When joining in title, here are the joins you might want to use
- explore: title_simple
  extension: required
  joins:
    - join: us_opening_weekend
      from: us_boxoffice
      sql_on: ${title.id} = ${us_opening_weekend.movie_id} and us_opening_weekend.weekend_number = 1
      fields: [us_opening_weekend.movie_id, us_opening_weekend.weekend_amount]
      relationship: many_to_one
  

