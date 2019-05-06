class AddRatesToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :rates, :json
  end
end
