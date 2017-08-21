class User < ApplicationRecord
  has_many :playlists
  has_secure_password
  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
end
