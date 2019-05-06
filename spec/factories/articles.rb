FactoryGirl.define do
  factory :article do
    product 
    status { 'exist' }
    imported_price { 1500 }
  end
end