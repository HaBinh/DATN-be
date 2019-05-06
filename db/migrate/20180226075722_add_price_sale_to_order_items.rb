class AddPriceSaleToOrderItems < ActiveRecord::Migration[5.1]
  def change
    add_column :order_items, :price_sale, :float
  end
end
