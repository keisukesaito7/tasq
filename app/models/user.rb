class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true

  has_many :permissions
  has_many :tasks, through: :permissions, dependent: :delete_all
  has_many :commits,  dependent: :delete_all
  has_many :messages, dependent: :delete_all
end
