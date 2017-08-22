# Playlist

* Its possible to add Artists, Genres, Songs and to create a Playlist

The DB model is the following: 

![DB Model](https://gab1davila.files.wordpress.com/2017/08/playlist-model.png)

## Set up

Run one by one in this order:

```
rake db:migrate
rails db < db/artists.sql
rails db < db/songs.sql
rake sunspot:solr:run &
rake db:seed
```