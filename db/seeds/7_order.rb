# imported_price = [999,888,345,899,786,1100,2009,678,123,90,200]
pro = [2100, 2000, 750, 1820, 1620, 2150, 4050, 1500, 450, 430, 540]
@rates = [0, 0.02, 0.05, 0.1, 0.2, 0.3, 0.5]

@prng = Random.new
(0..12).each do |month|
  50.times do
    customer = Customer.all.sample
    created_at = Faker::Date.between((month + 1).months.ago, (month).months.ago)
    order = Order.create!(
        customer_id: customer.id,
        customer_paid: 0,
        created_at: created_at
    )
    # create order items
    total_amount = 0
    countPro = @prng.rand(1..3)
    countPro.times do
      product = Product.all.sample
      price_sale = product.default_sale_price
      discounted_rate = @rates.sample
      quantity = @prng.rand(1..10)
      amount = (price_sale * quantity * (1 - discounted_rate)).round(-3)
      total_amount += amount

      order.order_items.create!(
          quantity: quantity,
          discounted_rate: discounted_rate,
          product_id: product.id,
          price_sale: price_sale,
          amount: amount,
          created_at: created_at,
      )
    end

    total_amount = total_amount.round(-3)
    customer_paid = total_amount
    a = @prng.rand(0..6)
    if a === 1
      customer_paid *= 0.8
    else
      if a === 2
        customer_paid *= 0.5
      end
    end
    customer_paid = customer_paid.round(-3)
    order.update_attributes(customer_paid: customer_paid, total_amount: total_amount)
    order.set_fully_paid
  end
end
