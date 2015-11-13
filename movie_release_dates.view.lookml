- view: movie_release_dates
  derived_table:
    persist_for: 100 hours
    indexes: [movie_id]
    sql: |
      SELECT 
        * 
        , ROW_NUMBER() OVER(ORDER BY movie_id, release_date) as id
        , RANK() OVER(PARTITION BY movie_id ORDER BY release_date) as index
      FROM (
        SELECT 
          movie_id
          , note as kind
            {% if _dialect._name contains 'spark' %}
              , SPLIT(info,':')[0] as country
              , SPLIT(info,':')[1] as date_string
              , CASE 
                WHEN SPLIT(info,':')[1] RLIKE '^\\d\\d [A-Za-z]+ \\d\\d\\d\\d$'
                  THEN FROM_UNIXTIME(UNIX_TIMESTAMP(SPLIT(info,':')[1],'dd MMMMM yyy'),'yyy-MM-dd')
                -- WHEN SPLIT_PART(info,':',2) ~ '^[A-Za-z]+ \\d\\d\\d\\d$'
                --  THEN TO_DATE( SPLIT_PART(info,':',2), 'Month YYYY')
                -- WHEN SPLIT_PART(info,':',2) ~ '^\\d\\d\\d\\d$'
                --  THEN TO_DATE( SPLIT_PART(info,':',2), 'YYYY')
                ELSE NULL
              END as release_date
            {% else %}
             , SPLIT_PART(info,':',1) as country
             , SPLIT_PART(info,':',2) as date_string
             , 
             CASE 
                WHEN SPLIT_PART(info,':',2) ~ '^\\d\\d [A-Za-z]+ \\d\\d\\d\\d$'
                  THEN TO_DATE( SPLIT_PART(info,':',2), 'DD Month YYYY')
                WHEN SPLIT_PART(info,':',2) ~ '^[A-Za-z]+ \\d\\d\\d\\d$'
                  THEN TO_DATE( SPLIT_PART(info,':',2), 'Month YYYY')
                WHEN SPLIT_PART(info,':',2) ~ '^\\d\\d\\d\\d$'
                  THEN TO_DATE( SPLIT_PART(info,':',2), 'YYYY')
                ELSE NULL
              END as release_date
            {% endif %}
        FROM movie_info
        WHERE 
          movie_info.info_type_id = 16
      ) AS BOO
      WHERE release_date IS NOT NULL
      
  fields:
  - dimension: id
    hidden: true
    primary_key: true

  - dimension: movie_id
    hidden: true
    
  - dimension: country

  - dimension: date_string

  - dimension_group: release
    type: time
    timeframes: [date, week, month, year]
    sql: ${TABLE}.release_date

  - dimension: kind
  
  - dimension: index
    type: number
    
  - measure: count
    type: count
    drill_fields: [id, title.title, title.id, country, release_date, index, kind]



    
    