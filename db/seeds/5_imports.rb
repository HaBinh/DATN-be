@prng = Random.new

(0..12).each do |month|
  created_at = Faker::Date.between((month + 1).months.ago, (month).months.ago)
  20.times do
    product = Product.all.sample
    quantity = @prng.rand(1..100)
    rand = @prng.rand(1..6)
    quantity_sold = quantity if rand == 4
    quantity_sold = @prng.rand(0..quantity) if rand != 4
    product.imports.create!(
        imported_price: product.default_sale_price,
        product_id: product.id,
        user_id: User.first.id,
        quantity: quantity,
        quantity_sold: quantity_sold,
        created_at: created_at
    )
  end
end