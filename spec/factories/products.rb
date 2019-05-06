FactoryGirl.define do
  factory :product do
    name { Faker::Name.name }
    code { Faker::Code.imei  }
    unit { Faker::Color.color_name}
    default_imported_price { "1000" }
    default_sale_price { "1500" }    
  end
end