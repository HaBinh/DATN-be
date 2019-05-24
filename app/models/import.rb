class Import < ApplicationRecord
  belongs_to :product
  belongs_to :user


  def quantity_left
    quantity - quantity_sold
  end
end
