sql = 
"update order_items 
set product_id = ( select articles.product_id 
    from articles 
    where articles.order_item_id = order_items.id
    limit 1 
)"

sql1 = 
"update order_items 
set price_sale = ( select products.default_sale_price 
    from products 
    where products.id = order_items.product_id
    limit 1 )
"
ActiveRecord::Base.connection.execute(sql)
ActiveRecord::Base.connection.execute(sql1)