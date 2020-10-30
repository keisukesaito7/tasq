class Permission < ApplicationRecord
  belongs_to :user
  belongs_to :task

  validates :user_id, uniqueness: { scope: :task_id, message: "は既に許可されています" }

  def self.excepted(current_user, task)
    where.not(user_id: [current_user.id, task.user_id]).includes(:user).order('created_at DESC')
  end
end
