class Like < ApplicationRecord
  belongs_to :user
  belongs_to :playlist
  include PublicActivity::Model
  tracked only: [:create], owner: :user

end
