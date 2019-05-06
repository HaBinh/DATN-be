json.order do 
    json.extract! @order, :id, :total_amount, :customer_paid, :debt, :fully_paid 
    json.paid_return_user @paid_return_user
end