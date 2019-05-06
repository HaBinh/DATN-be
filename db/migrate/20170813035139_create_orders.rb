class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders, id: false, primary_key: :id do |t|
      t.string :id, primary: true, unique: true, null: false
      t.references :customer, foreign_key: true
      t.float :customer_paid
      t.boolean :fully_paid, default: :false
      
      t.timestamps
      t.index ["id"], name: "index_orders_on_id", unique: true
    end
    execute "ALTER TABLE orders ADD PRIMARY KEY (id);"
  end
end
