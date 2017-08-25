class Artist < ApplicationRecord
  has_many :songs

  validates :name, presence: true, uniqueness: true

  searchable do
    text :name
  end
end
