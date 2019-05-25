json.customers @customers_in_debt.each do |customer| 
  json.customer do
    json.extract! customer.customer, :id, :name, :email, :phone, :address, :level, :active
  end
  json.orders customer.orders.each do |order|
    json.extract! order, :id, :total_amount, :debt, :created_at
  end
  json.total_debt customer.total_debt
end