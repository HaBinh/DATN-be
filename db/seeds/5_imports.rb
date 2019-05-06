@prng = Random.new

Product.all.each do |product|
    quantity = @prng.rand(1..10)
    quantity_sold = @prng.rand(0..quantity)
    product.imports.create!(
        imported_price: 10000,
        product_id: product.id,
        user_id: User.first.id,
        quantity: quantity,
        quantity_sold: quantity_sold
    )
end