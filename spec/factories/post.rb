FactoryBot.define do
  factory :post do
    date { Faker::Date.between(from: '2023-01-01', to: '2023-12-31') }
    title { Faker::Lorem.characters(number:10) }
    body { Faker::Lorem.characters(number:50) }
  end
end