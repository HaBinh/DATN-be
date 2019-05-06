json.category do 
  json.extract! @category, :id, :category
  json.rates JSON.parse(@category.rates)
end