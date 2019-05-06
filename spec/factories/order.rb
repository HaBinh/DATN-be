FactoryGirl.define do
  factory :order do
    customer  
    customer_paid { 4000 }
    total_amount { 4000 }
  end
end