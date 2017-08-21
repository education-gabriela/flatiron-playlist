class Genre < ApplicationRecord
  has_many :song_genres

  validates :name, presence: true, uniqueness: true
end
