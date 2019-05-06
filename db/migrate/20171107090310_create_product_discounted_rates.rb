class CreateProductDiscountedRates < ActiveRecord::Migration[5.1]
  def change
    create_table :product_discounted_rates do |t|
      t.float :rate
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
