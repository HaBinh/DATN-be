json.stores @results.each do |store| 
    json.id                 store["id"] 
    json.name               store["name"]
    json.code               store["code"]
    json.default_sale_price store["default_sale_price"]
    json.quantity           store["quantity"] == nil ? 0 : store["quantity"]
end