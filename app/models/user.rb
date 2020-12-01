class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :nickname, presence: true, length: { maximum: 10 }

  # レビュアーとしての許可証を削除
  has_many :permissions, dependent: :delete_all
  has_many :tasks, dependent: :destroy
  has_many :commits,  dependent: :delete_all
  has_many :messages, dependent: :delete_all
  has_many :likes, dependent: :delete_all

  def self.guest
    find_or_create_by!(email: 'guest1@gmail.com') do |user|
      user.nickname = 'guest1'
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def self.guest_beta
    find_or_create_by!(email: 'guest2@gmail.com') do |user|
      user.nickname = 'guest2'
      user.password = SecureRandom.urlsafe_base64
    end
  end

  def already_liked?(task, commit)
    likes.exists?(task_id: task.id, commit_id: commit.id)
  end
end
