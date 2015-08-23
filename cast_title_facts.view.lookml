- view: cast_title_facts
  derived_table:
    persist_for: 100 hours
    indexes: [person_id]
    sql: |
      SELECT
        cast_info.person_id as person_id
        , COUNT(DISTINCT title.id) AS lifetime_titles
        , MIN(title.production_year) AS first_production_year
        , MAX(title.production_year) AS last_production_year
        , COUNT(DISTINCT title.production_year) AS years_with_titles
        , COUNT(DISTINCT CASE WHEN cast_info.role_id IN (1,2) THEN title.production_year ELSE NULL END) AS years_acted
        , COUNT(DISTINCT CASE WHEN title.kind_id = 7 THEN title.id ELSE NULL END) as lifetime_tv_episodes
        , COUNT(DISTINCT CASE WHEN title.kind_id = 1 THEN title.id ELSE NULL END) as lifetime_movies
        , COUNT(DISTINCT CASE WHEN title.kind_id = 1 AND movie_revenue.usa_revenue > 0 THEN title.id ELSE NULL END) as lifetime_movies_with_revenue
        , COUNT(DISTINCT CASE WHEN cast_info.role_id IN (1,2) THEN title.id ELSE NULL END) AS lifetime_titles_acted
        , COUNT(DISTINCT CASE WHEN cast_info.role_id IN (3) THEN title.id ELSE NULL END) AS lifetime_titles_produced
        , COUNT(DISTINCT CASE WHEN cast_info.role_id IN (4) THEN title.id ELSE NULL END) AS lifetime_titles_as_writer
        , COUNT(DISTINCT CASE WHEN cast_info.role_id IN (8) THEN title.id ELSE NULL END) AS lifetime_titles_directed

      FROM title AS title
      LEFT JOIN  cast_info ON title.id = cast_info.movie_id
      LEFT JOIN  name ON cast_info.person_id = name.id
      LEFT JOIN ${movie_revenue.SQL_TABLE_NAME} AS movie_revenue ON title.id = movie_revenue.movie_id
      GROUP BY 1
  fields:
  - dimension: person_id
    hidden: true
    primary_key: true
    
  - dimension: lifetime_titles
    label: Lifetime Number Titles (in which they worked)
    type: number
    
  - dimension: lifetime_titles_tiered
    type: tier
    tiers: [1,3,10,20,50]
    style: integer
    sql: ${lifetime_titles}
    
  - dimension: first_production_year
    label: First Production Year (in which they worked)
    type: number
    
  - dimension: last_production_year
    label: Last Production Year (in which they worked)
    type: number
    
  - dimension: years_with_titles
    label: Number of Unique Production Years (in which they worked)
    type: number
    description: number of different years with titles
    
  - measure: average_years_with_titles
    label: Average Number of Unique Production Years (in which they worked)
    type: average
    sql: ${years_with_titles}
    description: number of different years with titles
    decimals: 2
    
  - dimension: years_worked
    label: Years Between the First Year they worked and the Last
    type: number
    sql: ${last_production_year} - ${first_production_year} + 1
    description: Difference between first production year and last production year +1

  - measure: average_years_worked
    label: Average Number of Years Between the First Year they worked and the Last
    type: average
    sql: ${years_worked}
    description: Difference between first production year and last production year +1
    decimals: 2

  - dimension: years_acted
    label: Number of Unique Production Years where the Job was Acting (in which they worked)
    type: number
    description: number of distinct production years where the role was acting

  - measure: average_years_acted
    label: Average Number of Unique Production Years where the Job was Acting (in which they worked)
    type: average
    sql: ${years_acted}
    description: number of distinct production years where the role was acting
    decimals: 2

  - dimension: lifetime_tv_episodes
    type: number

  - dimension: lifetime_lifetime_tv_episodes_tiered
    type: tier
    tiers: [1,3,10,20,50]
    style: integer
    sql: ${lifetime_tv_episodes}
    
  - dimension: lifetime_movies
    type: number    

  - dimension: lifetime_movies_tiered
    type: tier
    tiers: [1,3,10,20,50]
    style: integer
    sql: ${lifetime_movies}
    
  - dimension: lifetime_movies_with_revenue
    type: number

  - dimension: lifetime_movies_with_revenue_tiered
    type: tier
    tiers: [1,3,10,20,50]
    style: integer
    sql: ${lifetime_movies_with_revenue}
    
  - dimension: bling
    sql: |
      CASE WHEN ${lifetime_movies_with_revenue} > 5 THEN 'Movie$|' ELSE '' END
      || CASE WHEN ${lifetime_titles_acted} > 20 THEN 'actor|' ELSE '' END
      || CASE WHEN ${lifetime_tv_episodes} > 20 THEN 'tv|' ELSE '' END
      || CASE WHEN ${lifetime_titles_directed} > 5 THEN 'director|' ELSE '' END
      || CASE WHEN ${lifetime_titles_produced} > 5 THEN 'producer|' ELSE '' END
      || CASE WHEN ${lifetime_titles_as_writer} > 5 THEN 'writer|' ELSE '' END
    html: |
      {{ value }}
      {%if value contains 'star' %} &#x1f31f; {%endif%}
      {%if value contains 'tv' %} &#x1F4FA; {%endif%}
      
  - dimension: lifetime_titles_acted
    hidden: true
  - dimension: lifetime_titles_directed
    hidden: true
  - dimension: lifetime_titles_produced
    hidden: true
  - dimension: lifetime_titles_as_writer
    hidden: true
    
- view: cast_top_genre
  derived_table:
    persist_for: 100 hours
    indexes: [person_id]
    sql: |
      SELECT
        person_id
        , genre as top_genre
      FROM (
        SELECT
          cast_info.person_id as person_id
          , genre.genre as genre
          , COUNT(*) AS num_titles
          , ROW_NUMBER() OVER(PARTITION BY person_id ORDER BY num_titles DESC) as genre_rank
        FROM title 
        LEFT JOIN cast_info AS cast_info ON title.id = cast_info.movie_id
        LEFT JOIN ${movie_genre.SQL_TABLE_NAME} AS genre ON title.id = genre.movie_id
        GROUP BY 1,2
      ) AS BOO
      WHERE genre_rank = 1
  fields:
  - dimension: person_id
    hidden: true
    primary_key: true
    
  - dimension: top_genre
    