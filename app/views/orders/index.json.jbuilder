json.total @total
json.orders @orders.each do |order|
  json.extract! order, :id, :total_amount, :customer_paid, :fully_paid, :debt
  json.created_at order.created_at.strftime("%d-%m-%Y %H:%M")

  json.customer do 
    json.id order.customer_id
    json.extract! order, :name, :email, :phone, :address
  end
end