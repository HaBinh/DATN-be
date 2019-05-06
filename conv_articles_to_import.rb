x = Article.all.order(:created_at)
current = x[0]

import = Import.new(
  created_at:     current.created_at, 
  user_id:        current.created_by, 
  product_id:     current.product_id, 
  imported_price: current.imported_price,
  quantity: 1,
  quantity_sold:  current.status == 'sold' ? 1 : 0
)

i=1
while (i<x.count) 
  
  if  (x[i].created_by == current.created_by) && 
      (x[i].product_id == current.product_id) && 
      (x[i].imported_price == current.imported_price)
        import.quantity += 1
        import.quantity_sold += x[i].status == 'sold' ? 1 : 0
  else 
    import.save
    puts i
    import = Import.new(
      created_at:     x[i].created_at, 
      user_id:        x[i].created_by, 
      product_id:     x[i].product_id, 
      imported_price: x[i].imported_price,
      quantity: 1,
      quantity_sold:  x[i].status == 'sold' ? 1 : 0
    )
    current = x[i]
  end
  i +=1
end
import.save