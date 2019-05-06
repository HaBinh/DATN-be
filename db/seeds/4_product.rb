@prng = Random.new


200.times do |n| 
  Product.create!(
    name: "Product #{n}",
    code: "#{n}",
    unit: "Cai",
    default_imported_price: n+1,
    default_sale_price: n+100,
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