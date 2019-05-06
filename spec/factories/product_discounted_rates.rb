FactoryGirl.define do
    factory :product_discounted_rate do
        id {1}
        rate {0.1}
        product
    end
end
