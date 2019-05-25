class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product
  has_many :articles, dependent: :destroy
  validates :quantity, numericality: { greater_than: 0 }
  validates :discounted_rate, numericality: { greater_than: -1 }
  
  def calculate_amount(price_sale)
    amount = myCeil(price_sale * (1 - discounted_rate)) * quantity.to_i
    self.update_attributes(amount: amount)
  end

  def return_calculate_after_return(quantity_return)
    self.amount = myCeil(((self.amount / self.quantity ) * ( quantity - quantity_return )))
    self.quantity = self.quantity - quantity_return
    self.save
  end
end
