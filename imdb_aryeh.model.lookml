- connection: imdb-aryeh

- include: "*.view.lookml"       # include all the views
- include: "*.dashboard.lookml"  # include all the dashboards

- explore: aka_name

- explore: aka_title

- explore: cast_info

- explore: char_name

- explore: company_name

- explore: complete_cast

- explore: keyword

- explore: movie_companies

- explore: movie_info

- explore: movie_info_idx

- explore: movie_keyword
  joins:
    - join: keyword
      foreign_key: keyword_id


- explore: movie_link

- explore: name

- explore: person_info

- explore: title

