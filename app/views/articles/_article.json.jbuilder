json.extract! article, :id, :status, :imported_price
json.created_at article.created_at.strftime("%d-%m-%Y %H:%M")
product = Product.find_by_id(article.product_id)
json.product_id product.id
json.exist article.product.unit
json.sold article.product.name
json.extract! product, :name, :code, :unit, :default_imported_price, :default_sale_price