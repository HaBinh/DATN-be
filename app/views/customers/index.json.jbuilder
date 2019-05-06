json.total @total
json.customers @customers.each do |customer| 
  json.extract! customer, :id, :name, :email, :phone, :address, :level, :active
end