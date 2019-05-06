# json.discounted_rates @discoutedRates.each do |rate|
#   json.extract! rate, :id, :rate, :product_id
# end

json.discounted_rates do 
  json.array! @discoutedRates, partial: 'product_discoutedrates/product_discoutedrate', as: :discoutedRate
end