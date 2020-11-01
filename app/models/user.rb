class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, length: { maximum: 10 }

  has_many :permissions
  has_many :tasks, dependent: :destroy
  has_many :commits,  dependent: :delete_all
  has_many :messages, dependent: :delete_all

  def self.guest
    find_or_create_by!(email: "guest@test.com") do |user|
      user.nickname = "テストユーザー"
      user.password = SecureRandom.urlsafe_base64
    end
  end
end
