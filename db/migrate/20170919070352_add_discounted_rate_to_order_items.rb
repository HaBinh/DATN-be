class AddDiscountedRateToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :discounted_rate, :float
  end
end
