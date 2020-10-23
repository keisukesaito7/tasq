FactoryBot.define do
  factory :commit do
    content { Faker::Lorem.sentence }

    association :user
    association :task
  end
end
