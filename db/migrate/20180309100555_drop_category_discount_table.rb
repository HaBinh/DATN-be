class DropCategoryDiscountTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :category_discounts
  end
end
