class CreateProducts < ActiveRecord::Migration[5.1]
  def change
    create_table :products do |t|
      t.string :name
      t.string :code 
      t.string :category
      t.float :default_imported_price
      t.float :default_sale_price

      t.timestamps
    end
  end
end
