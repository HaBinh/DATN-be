class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string  :status
      t.float   :imported_price
      t.integer  :created_by
      t.references :product, foreign_key: true

      t.timestamps
    end
  end
end
