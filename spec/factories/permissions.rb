FactoryBot.define do
  factory :permission do
    association :user
    association :task
  end
end
