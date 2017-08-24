class User < ApplicationRecord
  has_many :playlists, dependent: :destroy
  has_many :playlist_songs, through: :playlists
  has_many :songs, through: :playlist_songs
  has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :passive_relationships, class_name: "Relationship", foreign_key:"followed_id", dependent: :destroy
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :likes, :dependent => :delete_all
  has_many :liked_playlists, :through =>  :likes, :source => :playlist
  has_many :comments

  validates :name, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true

  has_secure_password

  searchable do
    text :name
    text :email
  end

  def follow(other_user)
    following << other_user
  end

  def unfollow(other_user)
    following.delete(other_user)
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def gravatar_hash
    Digest::MD5.hexdigest self.email
  end

  def self.from_omniauth(auth)
    where(uid: auth.uid).new do |user|
      user.email = auth.info.email
      user.name = auth.info.name
    end
  end


end
