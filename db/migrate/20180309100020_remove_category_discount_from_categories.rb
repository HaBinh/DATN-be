class RemoveCategoryDiscountFromCategories < ActiveRecord::Migration[5.1]
  def change
    remove_reference :categories, :category_discount, foreign_key: true
  end
end
