module Status
  EXIST = 'exist'
  SOLD = 'sold'
end
class Article < ApplicationRecord
  belongs_to :product

  def beSold(order_item_id)
	update_attributes(status: Status::SOLD, order_item_id: order_item_id)
  end

  def beReturn
	update_attributes(status: Status::EXIST, order_item_id: nil)
  end
  def self.get_pagination(search_text, page, per_page)
	  if page
      WillPaginate::Collection.create(page, per_page) do |pager|
        if search_text.blank?
          sql2="select *, imports.created_at as time from imports
					      JOIN products ON products.id = imports.product_id
					      LIMIT #{pager.per_page} OFFSET #{pager.offset}"
          @ketqua = ActiveRecord::Base.connection.execute(sql2).to_a
        else
          search_text = "%#{search_text}%"
          sql="select *, imports.created_at as time from imports
					    JOIN products ON products.id = imports.product_id
              WHERE (name LIKE '#{search_text}' or code LIKE '#{search_text}')
              LIMIT #{pager.per_page} OFFSET #{pager.offset}"
          sql1="select *, imports.created_at as time from imports
					      JOIN products ON products.id = imports.product_id
              WHERE (name LIKE '#{search_text}' or code LIKE '#{search_text}')"

          @ketqua = ActiveRecord::Base.connection.execute(sql).to_a
          @total = ActiveRecord::Base.connection.execute(sql1).to_a.count
        end
      end
    else 
  			sql3="select *, imports.created_at as time from imports
					    JOIN products ON products.id = imports.product_id"
  		  @ketqua = ActiveRecord::Base.connection.execute(sql3).to_a
  	end
  	
		if search_text.blank?
			sql4="select *, imports.created_at as time from imports
					  JOIN products ON products.id = imports.product_id"

		  @total = Article.connection.select_all(sql4).to_a.count
		end

		return @ketqua, @total
  end
end
  