class AddLevelToCustomers < ActiveRecord::Migration[5.1]
  def change
    add_column :customers, :level, :integer
  end
end
