FactoryGirl.define do
  factory :import do
    product 
    user
    quantity { 10 }
    quantity_sold { 4 }
  end
end