class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :posts, dependent: :destroy
end
