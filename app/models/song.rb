class Song < ApplicationRecord
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs
  include PublicActivity::Model
  tracked only: [:create], owner: :user

  validates :title, :artist, presence: true
end
