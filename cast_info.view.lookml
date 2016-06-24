- view: cast_info
  sql_table_name: cast_info
  fields:

  - dimension: id
    primary_key: true
    type: number
    sql: ${TABLE}.id
    hidden: true

  - dimension: movie_id
    type: number
    sql: ${TABLE}.movie_id
    hidden: true

  - dimension: note
    sql: ${TABLE}.note

  - dimension: named_role_order
    type: number
    sql: ${TABLE}.nr_order
    
  - measure: average_named_role_order
    type: average
    sql: ${named_role_order}

  - dimension: person_id
    type: number
    sql: ${TABLE}.person_id
    hidden: true

  - dimension: person_role_id
    type: number
    sql: ${TABLE}.person_role_id
    hidden: true

  - dimension: role_id
    type: number
    sql: ${TABLE}.role_id
    hidden: true
    
  - dimension: role
    label: Role (Job they performed)
    sql_case:
      Actor: ${role_id} IN (1, 2)
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
      

  - measure: person_in_role_count
    type: count
    drill_fields: [id, name.person_name, role]