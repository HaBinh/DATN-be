FactoryGirl.define do
  factory :customer do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    phone { '01234213232'}
    address { Faker::Address.city }
    level { 0 }
    active { 'true'}
  end
end