- view: movie_revenue
  derived_table:
    #persist_for: 100 hours
    #indexes: [movie_id]
    sql: |
      SELECT 
        movie_id,
        MAX(max_revenue) as usa_revenue
      FROM ${movie_weekend_revenue.SQL_TABLE_NAME} as mr
      GROUP BY movie_id
    
  fields:
  - dimension: movie_id
    primary_key: true
    hidden: true
    
  # Hide these because they are confusing.
  
  - dimension: usa_revenue
    type: number
    hidden: true
    value_format: '$#,##0.00 \M'
    
  - dimension: revenue
    type: number
    hidden: true
    sql: ${usa_revenue}
    value_format: '$#,##0.00 \M'
    
  - measure: total_revenue
    type: sum
    sql: ${revenue}
    value_format: '$#,##0.00 \M'
 
  - measure: average_revenue
    type: average
    sql: ${revenue}
    value_format: '$#,##0.00 \M'

    
#   - measure: total_revenue2
#     type: number
#     sql: SUM(DISTINCT ${revenue})
#     value_format: '$#,##0.00 \M'
    
    