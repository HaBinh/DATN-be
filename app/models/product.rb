class Product < ApplicationRecord
    has_many :articles, dependent: :destroy
    has_many :imports
    belongs_to :category, optional: true
    has_many :product_discounted_rates, dependent: :destroy
    validates_presence_of :name, :code, :default_imported_price, :default_sale_price
    validates :default_imported_price, numericality: { greater_than: 0 }
    validates :default_sale_price, numericality: { greater_than: 0 }

    def self.get_pagination(search_text, page, per_page)
        if page
            WillPaginate::Collection.create(page, per_page) do |pager|
        unless search_text.nil? || search_text.blank?
          search_text = "%#{search_text}%"
                    @ketqua = ProductDiscountedRate.order(:id).joins("inner join (select * from products 
                            where active='true' and (name LIKE '#{search_text}' or code LIKE '#{search_text}')
                            order by code 
                            limit #{pager.per_page} offset #{pager.offset}) as products 
              ON product_discounted_rates.product_id = products.id",
              )
            .select("products.*, rate")
          @total = Product.where("active='true' and (name LIKE '#{search_text}' or code LIKE '#{search_text}')").count
                else
                    @ketqua = ProductDiscountedRate.order(:id).joins("inner join (select * from products 
                                where active='true'
                                order by code 
                                limit #{pager.per_page} offset #{pager.offset}) as products 
                                ON product_discounted_rates.product_id = products.id")
              .select("products.*, rate")
                end
            end
        else 
            @ketqua = ProductDiscountedRate.order(:id).joins("inner join (select * from products 
                            where active='true' 
                            order by code ) as products 
                            ON product_discounted_rates.product_id = products.id")
                        .select("products.*, rate")
    end
    

    if search_text.blank?
      @total = Product.where(active: true).count
    end
        return @ketqua, @total
    end
end
