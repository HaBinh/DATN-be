article=@article
json.article do
	  json.id article.product.id
	  json.code article.product.code
	  json.name article.product.name
	  json.imported_price article.imported_price
	  json.quantity params[:quantity]
	  json.sold 0
	  json.created_at article.created_at.to_datetime
end