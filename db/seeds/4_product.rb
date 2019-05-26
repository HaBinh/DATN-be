@prng = Random.new


50.times do |n|
  default_imported_price = @prng.rand(10..900) * 1000

  Product.create!(
    name: Faker::Commerce.unique.product_name,
    code: "#{n}",
    unit: "Cai",
    default_imported_price: default_imported_price,
    default_sale_price: default_imported_price +  @prng.rand(10..90) * 1000,
    category_id: Category.all.sample(1).first.id
  )
end
# //discounted rate for product
product_rates = [0.01,0.02,0.03,0.05,0.08,0.1,0.12,0.15,0.18,0.2,0.22,0.25,0.3,0.4,0.5]
Product.all.each do |product| 
    discountRates = product_rates.sample(6)
    discountRates.push(0).sort!.each do |rate|
      ProductDiscountedRate.create!(
        rate: rate,
        product_id: product.id
      )
    end
end