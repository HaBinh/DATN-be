json.products do
  json.array! @order_items, :code, :name, :quantity,:total_amount
end