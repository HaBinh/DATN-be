FactoryGirl.define do
  factory :user do
    password { Faker::Internet.password(8) }
    email { Faker::Internet.email }
    confirmed_at { DateTime.now }
  end
end