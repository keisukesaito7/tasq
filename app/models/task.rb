class Task < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :purpose
    validates :goal
  end

  belongs_to :user
  has_many :permissions
  # タスクごとに発行した許可証を削除
  # user.permissionsは別途削除が必要
  has_many :users, through: :permissions, dependent: :delete_all
  has_many :commits,  dependent: :delete_all
  has_many :messages, dependent: :delete_all

  def self.as_reviewer(user)
    joins(:permissions).where(permissions: { user_id: user.id }).includes(:user).order('created_at DESC')
  end
end
