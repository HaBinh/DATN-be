category_discounts = [0.01,0.02,0.03,0.05,0.08,0.1,0.12,0.15,0.18,0.2,0.22,0.25,0.3,0.4,0.5]

10.times do |n|
    category_discount = category_discounts.sample(6).push(0).sort!
    Category.create!(
        category: Faker::Commerce.material,
        rates: category_discount.to_json
    )
end