class Friendship < ApplicationRecord
  belongs_to :followed
  belongs_to :follower
end
