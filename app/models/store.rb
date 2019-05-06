class Store < ApplicationRecord
  belongs_to :product
  has_many :order_items, dependent: :destroy

  def self.get_pagination(search_text, page, per_page)
	  if page
      WillPaginate::Collection.create(page, per_page) do |pager|
        if search_text.blank?
          sql2="select * from
                  (select product_id, min(created_at) as time, (sum(quantity)-sum(quantity_sold)) as quantity
                  from imports
                  group by product_id) store
                Join products on store.product_id = products.id
                LIMIT #{pager.per_page} OFFSET #{pager.offset}"
          @ketqua = ActiveRecord::Base.connection.execute(sql2).to_a
        else
          search_text = "%#{search_text}%"
          sql="select * from
                (select product_id, min(created_at) as time, (sum(quantity)-sum(quantity_sold)) as quantity
                from imports
                group by product_id) store
                Join products on store.product_id = products.id
              WHERE (name LIKE '#{search_text}' or code LIKE '#{search_text}')
              LIMIT #{pager.per_page} OFFSET #{pager.offset}"
          sql1="select * from
                (select product_id, min(created_at) as time, (sum(quantity)-sum(quantity_sold)) as quantity
                from imports
                group by product_id) store
                Join products on store.product_id = products.id
              WHERE (name LIKE '#{search_text}' or code LIKE '#{search_text}')"

          @ketqua = ActiveRecord::Base.connection.execute(sql).to_a
          @total = ActiveRecord::Base.connection.execute(sql1).to_a.count
        end
      end
    else 
  			sql3="select * from
                (select product_id, min(created_at) as time, (sum(quantity)-sum(quantity_sold)) as quantity
                from imports
                group by product_id) store
                Join products on store.product_id = products.id"
  		  @ketqua = ActiveRecord::Base.connection.execute(sql3).to_a
  	end
  	
		if search_text.blank?
			sql4="select * from
              (select product_id, min(created_at) as time, (sum(quantity)-sum(quantity_sold)) as quantity
              from imports
              group by product_id) store
              Join products on store.product_id = products.id"

		  @total = Article.connection.select_all(sql4).to_a.count
		end
		return @ketqua, @total
  end
end 
    