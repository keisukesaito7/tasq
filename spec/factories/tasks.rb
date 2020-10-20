FactoryBot.define do
  factory :task do
    title   { Faker::Lorem.sentence }
    purpose { Faker::Lorem.sentence }
    goal    { Faker::Lorem.sentence }

    association :user
  end
end
