class ProductDiscoutedratesController < ApplicationController
    before_action :set_discoutedRates , only:[:show, :update]
    def index
        @discoutedRates = ProductDiscountedRate.where(product_id: params[:id]).sort { |x,y| x.rate <=> y.rate }
    end

    def show

    end

    def update
        # byebug
        @discoutedRates.update_attributes(rate_params)
        render json: {discoutedRates: @discoutedRates}
    end

    def change
        @category = Category.find_by_id(params[:_json])
        @rate = JSON.parse(@category.rates)
        @products = @category.products
        @products.each do |product|
            @discount_rates = product.product_discounted_rates.order(:id)
            count = 0
            @discount_rates.each do |rate|
                rate.update_attributes(rate: @rate[count])
                count += 1
            end
        end
    end

    private
        def set_discoutedRates
            @discoutedRates = ProductDiscountedRate.find_by_id(params[:id])
        end

        def rate_params
            params.permit(:rate)
        end

end
