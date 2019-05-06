# imported_price = [999,888,345,899,786,1100,2009,678,123,90,200]
pro = [2100,2000,750,1820,1620,2150,4050,1500,450,430,540]
@rates = [0, 0.02, 0.05, 0.1, 0.2,0.3, 0.5]

@prng = Random.new
12.times do |n|
    # code order
    orderId = SecureRandom.hex(3).upcase
    5.times do |m|
      #product quantity
      countPro = @prng.rand(1..3)
      proPrice = pro.sample(countPro)
      #time ago
      time = Time.now - n.month
      #customer create
      customerId = @prng.rand(Customer.first.id..Customer.last.id)
      total = 0
      arr_quantity=[]
      arr_rate=[]
      user_id = @prng.rand(1..7)
      countPro.times do |t|
        quantity = @prng.rand(1..3)
        rate = @rates[@prng.rand(0..4)]
        arr_quantity << quantity
        arr_rate << rate
        total += proPrice[t]*quantity*(1-rate)
      end
      total_amount = total
      a = @prng.rand(0..2)
      if a === 1
        total *= 0.8
      else 
        if a === 2
          total *= 0.5
        end
      end
      if total === total_amount
        fully_paid = TRUE
      else
        fully_paid = FALSE
      end
      order = Order.create!(
        id: orderId,
        customer_id: customerId,
        created_at: time,
        total_amount: total_amount,
        customer_paid: total,
        fully_paid: fully_paid
      )
      countPro.times do |t|
        order_item = order.order_items.create!(
          order_id: order.id,
          quantity: arr_quantity[t],
          amount: proPrice[t]*(1-arr_rate[t])*arr_quantity[t],
          created_at: time,
          discounted_rate: arr_rate[t]
        )
        product_id = pro.index(proPrice[t]) + 1

        arr_quantity[t].times do |h|
          article = order_item.articles.create!(
              status: 'sold',
              created_by: user_id,
              imported_price:  proPrice[t]/2,
              product_id: product_id,
              created_at: time,
              order_item_id: order_item.id
            )
        end       
      end
    end
end