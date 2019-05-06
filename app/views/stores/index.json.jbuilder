json.total @total
json.stores @stores.each do |store|
	  json.id store["id"]
	  json.code store["code"]
	  json.name store["name"]
	  json.imported_price store["imported_price"]
	  json.quantity store["quantity"]
	  json.created_at store["time"].to_datetime
end