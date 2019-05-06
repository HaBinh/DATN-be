class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :destroy, :update]
      def index
        @article, @total1 = Article.get_pagination(params[:search], params[:page], params[:per_page])
        
        if !current_user.isManager
            @article.map { |a| a["imported_price"] = 0 }
        end
        @articles = @article
        @total = @total1
      end

      def create
        import_params = params.permit(:imported_price, :product_id, :quantity)
        @article = Import.new(import_params)
        @article.user_id = current_user.id
        @article.quantity_sold = 0
        @article.save
        if @article.save
          render 'articles/create.json.jbuilder'
        end
      end

      def update
        if @article.present?
          @article.update_attributes(quantity: params[:quantity], imported_price: params[:imported_price])
        end
      end
    
      def show 
    
      end

      def destroy
        if @article.nil? 
          render json: { message: 'Not found'}, status: :not_found
        else
          @article.delete
          head :ok
        end
      end
    
      private 
      def article_params
        params.permit(:status, :imported_price, :product_id)
      end
    
      def set_article
        @article = Import.find_by_id(params[:id])
        if @article.nil? 
          render json: { message: 'Not found'}, status: :not_found
        end
      end
end
