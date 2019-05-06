FactoryGirl.define do
  factory :order_item do
    order 
    quantity { 1 }
    amount { 1000 }
  end
end