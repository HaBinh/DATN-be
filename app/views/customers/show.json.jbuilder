json.customer do 
  json.extract! @customer, :id, :name, :email, :phone, :address, :level, :active
end