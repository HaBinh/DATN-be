json.extract! product, :id, :name, :code, :unit, :default_imported_price, :default_sale_price, :active, :category_id
rates = product.product_discounted_rates.order(:id).map do |rate| 
    rate.rate
end

json.rates rates