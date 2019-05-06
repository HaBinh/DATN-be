class CreateOrderItems < ActiveRecord::Migration[5.1]
  def change
    create_table :order_items do |t|
      t.string :order_id
      t.integer :quantity
      t.float :amount
      t.timestamps
    end
    add_foreign_key :order_items, :orders, column: :order_id, primary_key: :id
  end
end
