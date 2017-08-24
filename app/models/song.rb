class Song < ApplicationRecord
  belongs_to :artist
  has_many :song_genres
  has_many :genres, through: :song_genres
  has_many :playlist_songs
  has_many :playlists, through: :playlist_songs

  validates :title, :artist, presence: true

  searchable do
    text :title
    text :artist do
      artist.name if artist
    end
    integer :artist_id
  end

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    self.artist.name
  end
end
