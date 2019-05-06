prng = Random.new
50.times do |n|
  name =  Faker::Name.name
  email = Faker::Internet.email
  phone = Faker::PhoneNumber.phone_number
  address = Faker::Address.city
  level = prng.rand(0..6)
  Customer.create!(
    name: name,
    email: email,
    phone: phone,
    address: address,
    level: level
    )
end