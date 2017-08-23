class Playlist < ApplicationRecord
  belongs_to :user
  has_many :playlist_songs, dependent: :destroy
  has_many :songs, through: :playlist_songs
  has_many :likes, :dependent => :delete_all
  has_many :liking_users, :through => :likes, :source => :user

  include PublicActivity::Model
  tracked only: [:create], owner: :user

  validates :name, presence: true

  def like(user)
    likes << Like.new(user_id: user.id)
  end

  def unlike(user)
    likes.where(user_id: user.id).first.destroy
  end

  def liked?(user)
    likes.include?(user.id)
  end

end
