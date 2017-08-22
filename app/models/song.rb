class Song < ApplicationRecord
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres

  validates :title, :artist, presence: true
end