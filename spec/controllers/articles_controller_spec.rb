require 'rails_helper' 

RSpec.describe 'Articles API', type: :request do
  
  let!(:article) { create(:article) }
  let(:article_id) { article.id }

  let!(:product) { create(:product) }
  let(:product_id) { product.id } 
  
  let(:status) { 'sold' }
  let(:price_sale) { 1000 }
  
  let(:user) { create(:user) }
  let(:user_auth_headers) { user.create_new_auth_token }

  let(:user1) { create(:user,role: 'manager', name: 'hoc') }
  let(:user1_auth_headers) { user1.create_new_auth_token }

  let!(:article1) { create(:article, created_by: user1.id ) }
  let!(:article2) { create(:article, created_by: user.id ) }

  let(:valid_params) {
    {
        status: status,
        imported_price: price_sale,
        imported_price_old: 1500,
        product_id: product_id,
        quantity: 4
    }
  }
  let(:valid_params_add) {
    { 
        status: status,
        imported_price_old: 1500,
        imported_price: price_sale,
        product_id: product_id,
        new_quantity: 100
    }
  }
  let(:valid_params_add1) {
    { 
        status: status,
        imported_price_old: 1500,
        imported_price: price_sale,
        product_id: product_id,
        new_quantity: 5
    }
  }

    describe 'POST /api/articles for manager' do
      before { 
        post "/api/articles", params: valid_params, headers: user1_auth_headers 
      }
  
      it 'return status 201' do 
        expect_status 201
      end
      
    end

    describe 'POST /api/articles for staff ' do
      before { 
        post "/api/articles", params: valid_params, headers: user_auth_headers 
      }
  
      it 'return status 201' do 
        expect_status 201
      end
    end

    describe 'PUT /api/articles/update when sold = 0' do
      before { 
        put "/api/articles/update", params: valid_params, headers: user_auth_headers 
      } 
      it 'return status 200' do 
        expect_status 200
      end
    end

    describe 'PUT /api/articles/update when sold != 0' do  
      let!(:articles) { create_list(:article, 10, product_id: product_id, status: 'sold') }
      let(:article_id) { articles.first.id }
      before {      
        put "/api/articles/update", params: valid_params_add, headers: user_auth_headers 
      }
      it 'return status 200' do 
        expect_status 200
      end
    end

    describe 'PUT /api/articles/update' do
      before { 
        put "/api/articles/update", params: valid_params_add1, headers: user_auth_headers 
      } 
      it 'return status 200' do 
        expect_status 200
      end
    end
     
    describe 'DELETE /api/articles/:id' do 
      before { delete "/api/articles/#{article_id}", params: {}, headers: user_auth_headers }
  
      it 'should delete' do 
        expect(Article.count).not_to eq(@before_article_count)
      end
  
      it 'return status 200' do 
        expect_status 200
      end
    end
  
    describe 'GET /api/articles.json for staff' do 
      before { get "/api/articles.json", params: {}, headers: user_auth_headers }
      
      it 'return status 200' do 
        expect_status 200 
      end
    end

    describe 'GET /api/articles.json for manager' do 
      before { 
          get "/api/articles.json", params: {}, headers: user1_auth_headers 
          # byebug
      }
      
      it 'return status 200' do 
        expect_status 200 
      end
    end

  # create article status = 0 to test when sold > 0 
  let!(:article3) { create(:article, created_by: user1.id , status: 'sold') }
  let!(:article4) { create(:article, created_by: user.id , status: 'sold') }

    describe 'GET /api/articles.json when article sold for staff' do 
      before { get "/api/articles.json", params: {}, headers: user_auth_headers }
      
      it 'return status 200' do 
        expect_status 200 
      end
    end

    describe 'GET /api/articles.json  when article sold for manager' do 
      before { 
          get "/api/articles.json", params: {}, headers: user1_auth_headers 
          # byebug
      }
      
      it 'return status 200' do 
        expect_status 200 
      end
    end  
    
    describe 'GET /api/articles/:id' do 
      before { 
        get "/api/articles/#{article_id}.json", params: {}, headers: user_auth_headers
      }
  
      it 'return status 200' do 
        expect_status 200
      end
  
      it 'return correct types' do 
        expect_json_types('article', status: :string, imported_price: :float,product_id: :integer,name: :string, code: :string, default_imported_price: :float,
        default_sale_price: :float )
      end
    end
end
