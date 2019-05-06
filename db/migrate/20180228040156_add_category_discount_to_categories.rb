class AddCategoryDiscountToCategories < ActiveRecord::Migration[5.1]
  def change
    add_reference :categories, :category_discount, foreign_key: true
  end
end
