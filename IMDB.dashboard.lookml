- dashboard: imdb
  title: Imdb
  layout: tile
  tile_size: 100

#  filters:

  elements:

- name: add_a_unique_name_1451403152480
  title: Untitled Visualization
  type: looker_column
  model: imdb
  explore: title
  dimensions: [title.production_year, movie_genre.genre]
  pivots: [movie_genre.genre]
  measures: [title.count]
  filters:
    title.production_year: '[2000, 2015]'
  sorts: [movie_genre.genre, title.production_year]
  limit: 500
  column_limit: 50
  colors: ['#62bad4', '#a9c574', '#929292', '#9fdee0', '#1f3e5a', '#90c8ae', '#92818d',
    '#c5c6a6', '#82c2ca', '#cee0a0', '#928fb4', '#9fc190']
  label_density: 25
  font_size: medium
  legend_position: center
  y_axis_gridlines: true
  show_view_names: true
  y_axis_combined: true
  show_y_axis_labels: true
  show_y_axis_ticks: true
  y_axis_tick_density: default
  show_x_axis_label: true
  show_x_axis_ticks: true
  x_axis_scale: auto
