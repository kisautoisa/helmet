class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  has_many :posts, dependent: :destroy
  
  validates :name, presence: true
  validates :introduction, presence: true
end
