class Permission < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :user_id, uniqueness: { scope: :task_id, message: "は既に許可されています" }

  def self.excepted(current_user)
    where.not(user_id: current_user.id).includes(:user).order('created_at DESC')
  end
end
