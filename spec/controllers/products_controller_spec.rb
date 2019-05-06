require 'rails_helper'

RSpec.describe ProductsController, :type => :controller do

  let!(:product) { create(:product) }
  let(:product_id) { product.id }

  let(:user) { create(:user) }
  let(:user_auth_headers) { user.create_new_auth_token }
  describe 'GET index' do
    render_views
    fixtures :products
    it 'returns correct types' do
      request.headers.merge! user_auth_headers
      get :index, :format => :json
      expect_json_types(products: :array)
      expect_json_types('products.*', name: :string, code: :string, 
                                       unit: :string, default_imported_price: :float,
                                       default_sale_price: :float)
      # byebug
    end

    it 'return correct data' do 
      request.headers.merge! user_auth_headers
      get :index, :format => :json
      expect_json('products.0', { :id => product_id, :name => product.name })
      expect_status(200)
    end
  end

  describe 'GET show' do 
    fixtures :products
    render_views 
    it 'returns correct types' do 
      request.headers.merge! user_auth_headers
      get :show, params: { id: product_id}, :format => :json
      expect_json_types('product',  name: :string, code: :string, 
                                       unit: :string, default_imported_price: :float,
                                       default_sale_price: :float)
      expect_status(200)
    end

    it 'returns correct data' do 
      request.headers.merge! user_auth_headers
      get :show, params: { id: product_id}, :format => :json
      expect_json('product', { :id => product_id, :name => product.name })
    end
  end

  describe 'POST create'  do 
    render_views 
    fixtures :products 
    it 'return correct types' do
      request.headers.merge! user_auth_headers
      body = { 'name' => 'iphone', :code => '123456789', :unit => 'red', :default_imported_price => 1001,
                                   :default_sale_price => 1000 } 
      post :create, params: body, :format => :json
      expect_status(201)
      expect_json_types('product',  name: :string, code: :string, 
                                    unit: :string, default_imported_price: :float,
                                    default_sale_price: :float)
end
  end
end

RSpec.describe 'Products API', type: :request do
  let!(:products) { create_list(:product, 10) }
  let(:product_id) { products.first.id }

  let(:user) { create(:user) }
  let(:user_auth_headers) { user.create_new_auth_token }

  describe 'GET /api/products/:id ' do 
    before { 
      get "/api/products/#{product_id}.json", params: {}, headers: user_auth_headers 
    }

    context 'when the record not exists ' do
      let(:product_id) { 100 }

      it 'returns status code 404' do
        expect_status 404
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Not found/)
      end
    end
  end

  describe 'PUT /api/products/:id ' do
    let(:valid_attributes) { { name: 'iphone' }}

    context 'when the record exists' do 
      before { 
        put "/api/products/#{product_id}", params: valid_attributes, headers: user_auth_headers  }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'return status code 200' do 
        expect_status 200
      end
    end
  end

  describe 'DELETE /api/products/:id' do
    before { 
      delete "/api/products/#{product_id}", params: {}, headers: user_auth_headers 
    }

    it 'return status code 200' do 
      expect_status 200
    end

  end


end

