## Implementaiton Notes

### Model shared between dialects 
  * [imdb.model.lookml](imdb.model.lookml), [imdb_spark.model.lookml](imdb_spark.model.lookml), [imdb.base.lookml](imdb.base.lookml) 
* Runs both Spark and Redshift
* Uses a base file with a base explore, each model extends 
* Spark has really poorly optimized Left Joins, so we inner join
* Redshift doesn’t support lists
* liquid to conditionally compile based on dialect - [movie_budget.view.lookml](movie_budget.view.lookml)


### Reverse Join Pattern
* Single Base View (title) ~ 3M 
* Titles have Cast Memebers, Production Companies, Genres, Languages and Keywords
* Each of these attributes are one_to_many joins
* Many of the attributes we join twice so we can see co-occurances


### Polymorphic Table 
* Title is both tv episode and tv series.

### Break up movie_info with derived tables.

