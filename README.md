# Playlist

* Its possible to add Artists, Genres, Songs and to create a Playlist

The DB model is the following: 

![DB Model](https://gab1davila.files.wordpress.com/2017/08/playlist-model.png)

## Set up

Run one by one in this order:

```
rake sunspot:solr:run &
rake db:migrate
rails db < db/sql/artists.sql
rails db < db/sql/songs.sql
rake db:seed
```