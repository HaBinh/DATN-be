@prng = Random.new

Product.all.each do |product|

  20.times do
    quantity = @prng.rand(1..100)
    quantity_sold = @prng.rand(0..quantity)
    product.imports.create!(
        imported_price: 10000,
        product_id: product.id,
        user_id: User.first.id,
        quantity: quantity,
        quantity_sold: quantity_sold,
        created_at: Faker::Date.between(1.year.ago, 5.months.ago)
    )
  end

  20.times do
    quantity = @prng.rand(1..100)
    quantity_sold = @prng.rand(0..quantity)
    product.imports.create!(
        imported_price: 10000,
        product_id: product.id,
        user_id: User.first.id,
        quantity: quantity,
        quantity_sold: quantity_sold,
        created_at: Faker::Date.between(5.months.ago, Date.today)
    )
  end
end