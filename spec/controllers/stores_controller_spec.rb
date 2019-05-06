require 'rails_helper' 

RSpec.describe 'Stores API', type: :request do
  
  let!(:article) { create(:article) }
  let(:article_id) { article.id }

  let!(:product) { create(:product) }
  let(:product_id) { product.id } 
  
  let(:status) { 'sold' }
  let(:price_sale) { 1000 }
  
  let(:user) { create(:user) }
  let(:user_auth_headers) { user.create_new_auth_token }
    
    describe 'GET /api/stores.json' do 
      before { get "/api/stores.json", params: {}, headers: user_auth_headers }
      it 'return status 200' do 
        expect_status 200 
      end
    end

    describe 'GET /api/products.json' do 
        before { get "/api/get_products.json", params: {}, headers: user_auth_headers }
    
        it 'return status 200' do 
          expect_status 200 
        end
  
      end
  
end
