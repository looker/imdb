# TV Writers

Say you want to be a TV writer.  Is it a good career?  Who shoud you target talking to?  How long should I expect to work?  How many openings are there?  Let's investigate.

<look>
  type: table
  model: imdb
  explore: title
  dimensions: [cast_title_facts.first_production_year, company.company_name]
  pivots: [company.company_name]
  measures: [tv_series.tv_series_count, name.person_count, cast_title_facts.average_years_with_titles]
  filters:
    cast_info.role: Writer
    cast_title_facts.first_production_year: '1990 to'
    company.company_name: '"American Broadcasting Company (ABC)","National Broadcasting
      Company (NBC)",%CBS Television Studios%'
  sorts: [cast_title_facts.first_production_year desc]
  limit: 500
  column_limit: 50
  query_timezone: America/Los_Angeles

</look>

