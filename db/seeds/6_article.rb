@prng = Random.new
Product.all.each do |product|
  user_id = @prng.rand(1..4)
  exist = @prng.rand(1..10)
  sold = @prng.rand(0..5)
  time = Time.now
  
  exist.times do |n|
    product.articles.create!(
    status: 'exist',
    created_by: 1,
    product_id: product.id,
    imported_price: 200,
    created_at: time)
  end
  sold.times do |n|
    product.articles.create!(
    status: 'sold',
    created_by: 1,
    product_id: product.id,
    imported_price: 200,
    created_at: time)
  end
end