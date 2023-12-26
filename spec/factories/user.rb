FactoryBot.define do
  factory :user do
    name { Faker::Lorem.characters(number:8) }
    email { Faker::Internet.email }
    password { Faker::Lorem.characters(number:12) }
  end
end