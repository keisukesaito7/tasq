class Commit < ApplicationRecord
  validates :content, presence: true

  belongs_to :user
  belongs_to :task
  has_many :likes, dependent: :delete_all
end
