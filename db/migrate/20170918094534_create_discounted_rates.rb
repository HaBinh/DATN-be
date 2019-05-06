class CreateDiscountedRates < ActiveRecord::Migration[5.1]
  def change
    create_table :discounted_rates do |t|
      t.float :rate

      t.timestamps
    end
  end
end
