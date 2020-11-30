class Like < ApplicationRecord
  belongs_to :user
  belongs_to :task
  belongs_to :commit
end
