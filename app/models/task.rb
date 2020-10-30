class Task < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :purpose
    validates :goal
  end

  belongs_to :user
  has_many :permissions
  has_many :users, through: :permissions, dependent: :delete_all
  has_many :commits,  dependent: :delete_all
  has_many :messages, dependent: :delete_all

  def self.as_owner(user_id)
    where(user_id: user_id).order('created_at DESC')
  end

  def self.as_reviewer(user_id)
    where.not(user_id: user_id).order('created_at DESC')
  end
end
