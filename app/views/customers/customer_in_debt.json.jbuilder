json.customers @customers_in_debt.each do |customer| 
  json.customer do 
    json.partial! "customers/customer", customer: customer.customer
  end
  json.orders customer.orders.each do |order|
    json.extract! order, :id, :total_amount, :debt, :created_at
  end
  json.total_debt customer.total_debt
end