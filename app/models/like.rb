class Like < ApplicationRecord
  belongs_to :user
  belongs_to :task
  belongs_to :commit

  validates_uniqueness_of :commit_id, scope: :user_id
end
