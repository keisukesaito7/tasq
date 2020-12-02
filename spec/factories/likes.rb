FactoryBot.define do
  factory :like do
    association :user
    association :task
    association :commit
  end
end
