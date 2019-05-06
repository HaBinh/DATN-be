json.extract! order, :id, :total_amount, :customer_paid, :fully_paid, :debt, :created_at

json.customer do 
  customer = Customer.find_by_id(order.customer_id)
  json.extract! customer, :id, :name, :email, :phone, :address
end

order_items = order.order_items

json.order_items do 
  json.array! order_items, partial: 'order_items/order_item', as: :order_item
end
