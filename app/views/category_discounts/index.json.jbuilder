json.total @total
json.category_discounts @category_discounts.each do |category_discount|
	json.id	category_discount["id"]
    json.category category_discount["category"]
    json.rates [
        category_discount['rate0'], 
        category_discount["rate1"], 
        category_discount['rate2'], 
        category_discount['rate3'], 
        category_discount['rate4'], 
        category_discount['rate5'],
        category_discount['rate6']]
end