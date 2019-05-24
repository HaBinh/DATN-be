class StoresController < ApplicationController
  def index
    @ketqua, @total = Store.get_pagination(params[:search], params[:page], params[:per_page])
    @stores = @ketqua.sort { |x,y| y["time"] <=> x["time"] }
  end

  def create
        import_params = params.permit(:imported_price, :product_id, :quantity)
        @article = Import.new(import_params)
        @article.user_id = current_user.id
        @article.quantity_sold = 0
        @article.save
        if @article.save
          render 'stores/create.json.jbuilder'
        end
      end

  def get_products    
    sql =  "select products.id, products.name, code, unit, quantity, default_sale_price
            from products 
            left outer join ( select 
                sum(quantity - quantity_sold) as quantity,
                min(product_id) as product_id
            from imports 
            where quantity > quantity_sold
            group by product_id
            order by product_id
            ) as remain 
            on remain.product_id = products.id
            where active = 'true'"
    @results = ActiveRecord::Base.connection.execute(sql).to_a

    render 'stores/get_products'
  end

  def get_inventory_statistics
    @imports = Import.where('quantity > quantity_sold')
                   .joins(:product)
                   .select("imports.*, products.name, products.code ").order(created_at: :asc)
    render 'stores/get_inventory_statistics';
  end

  private 
      def article_params
        params.permit(:status, :imported_price, :product_id)
      end
end