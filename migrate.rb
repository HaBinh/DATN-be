imports = []
x = Article.all.order(:created_at)
current = x[0]

i=1
while (i<x.count) 
  if (x[i].created_at - current.created_at < 2000) && (x[i].created_by == current.created_by) && (x[i].product_id == current.product_id) && (x[i].imported_price == current.imported_price)
    different = x[i].created_at != current.created_at
    x[i].created_at = current.created_at
    x[i].save if different
  else
    current = x[i]
  end  
  i +=1
end