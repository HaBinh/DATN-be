json.total @total
json.categories @categories.each do |category|
	json.extract! category, :id, :category
	if category.rates != nil
		json.rates JSON.parse(category.rates)
	else
		json.rates ""
	end
end