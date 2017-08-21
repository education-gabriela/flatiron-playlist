class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_songs
  has_many :songs, through: :playlists
end
