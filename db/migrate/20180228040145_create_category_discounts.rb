class CreateCategoryDiscounts < ActiveRecord::Migration[5.1]
  def change
    create_table :category_discounts do |t|
      t.float :rate0
      t.float :rate1
      t.float :rate2
      t.float :rate3
      t.float :rate4
      t.float :rate5
      t.float :rate6

      t.timestamps
    end
  end
end
