class Task < ApplicationRecord
  with_options presence: true do
    validates :title
    validates :purpose
    validates :goal
  end

  belongs_to :user
end
