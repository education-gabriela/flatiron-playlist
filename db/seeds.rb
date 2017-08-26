32.times do |x|
  user = {name: Faker::Name.name, email: Faker::Internet.email, password: "123"}
  User.create(user)
end

playlists = ["Top 100", "Chilling", "Dancing", "New Releases", "Discover Weekly", "All out 70's", "Hit Rewind",
             "Oldies but Goodies", "Rock me UP!", "Covers", "Rock Solid", "Romantic", "Liked", "Favorites", "Classic",
             "Alternative"]

genres = [{name: "pop"}, {name: "rock"}, {name: "alternative"}, {name: "jazz"}, {name: "blues"}, {name: "classical"}]
Genre.create(genres)

playlists.each do |playlist_name|
  user_id = rand 1..User.maximum(:id)
  playlist = Playlist.new
  playlist.name = playlist_name
  playlist.user_id = user_id
  songs = []
  song_amount = rand 1..25
  song_amount.times do |x|
    songs << Song.all.sample.id
  end
  songs.uniq!
  playlist.song_ids = songs
  playlist.save
end

Song.all.each do |song|
  song.genre_ids = [Genre.all.sample.id]
end

User.reindex
Song.reindex
Artist.reindex
Sunspot.commit

# To run after import of playlists and assing a genre to it
# Song.left_joins(:genres).where(:genres => { :id => nil }).each  do |song|
#   song.genre_ids = [Genre.all.sample.id]
# end
