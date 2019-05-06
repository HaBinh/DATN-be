class CreateImports < ActiveRecord::Migration[5.1]
  def change
    create_table :imports do |t|
      t.float :imported_price
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.integer :quantity
      t.integer :quantity_sold

      t.timestamps
    end
  end
end
