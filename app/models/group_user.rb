class GroupUser < ApplicationRecord
  belongs_to :group
  belongs_to :user

  def self.user?(current_user, group_id)
    self.find_by(user_id: current_user, group_id: group_id)
  end

  def self.is_admin?(group, user)
    !self.find_by(group_id: group.id, user_id: user, is_admin: true).nil?
  end
end
