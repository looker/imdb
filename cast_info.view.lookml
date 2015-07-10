- view: cast_info
  sql_table_name: public.cast_info
  fields:

  - dimension: id
    primary_key: true
    type: int
    sql: ${TABLE}.id
    hidden: true

  - dimension: movie_id
    type: int
    sql: ${TABLE}.movie_id
    hidden: true

  - dimension: note
    sql: ${TABLE}.note

  - dimension: nr_order
    type: int
    sql: ${TABLE}.nr_order
    hidden: true

  - dimension: person_id
    type: int
    sql: ${TABLE}.person_id
    hidden: true

  - dimension: person_role_id
    type: int
    sql: ${TABLE}.person_role_id
    hidden: true

  - dimension: role_id
    type: int
    sql: ${TABLE}.role_id
    hidden: true
    
  - dimension: role
    sql_case:
      Actor (uncredited): ${role_id} = 1
      Actor: ${role_id} = 2
      Producer: ${role_id} = 3
      Writer: ${role_id} = 4
      Director of Photography: ${role_id} = 5
      Conductor: ${role_id} = 6
      Costume: ${role_id} = 7
      Director: ${role_id} = 8
      Editing: ${role_id} = 9
      Other Crew: ${role_id} = 10
      Production Design: ${role_id} = 11
      12: ${role_id} = 12
      

  - measure: count
    type: count
    drill_fields: [id]

