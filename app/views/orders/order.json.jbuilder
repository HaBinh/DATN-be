json.order do 
  json.extract! @order, :id, :total_amount, :customer_paid, :debt, :fully_paid, :created_at
end