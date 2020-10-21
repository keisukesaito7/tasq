class Commit < ApplicationRecord
  validates :content, presence: true
end
