class AddOrderItemToArticles < ActiveRecord::Migration[5.1]
  def change
    add_reference :articles, :order_item, foreign_key: true
  end
end
