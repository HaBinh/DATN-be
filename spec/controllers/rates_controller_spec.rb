require 'rails_helper'

RSpec.describe RatesController,:type => :controller do

  let!(:discounted_rate) { create(:discounted_rate) }
  let(:discounted_rate_id) { discounted_rate.id }

  let(:user) { create(:user) }
  let(:user_auth_headers) { user.create_new_auth_token }
  describe 'GET index' do
    render_views
    fixtures :discounted_rates  
    it 'returns correct types' do
      request.headers.merge! user_auth_headers
      get :index, :format => :json
      expect_json_types(discounted_rates: :array)
      expect_json_types('discounted_rates.*', rate: :float)     
    end
    it 'return correct data' do 
      request.headers.merge! user_auth_headers
      get :index, :format => :json
      expect_json('discounted_rates.*', { :id => discounted_rate_id, :rate => discounted_rate.rate })
      expect_status(200)
    end
  end 
  # describe 'POST create'  do 
  #   render_views 
  #   fixtures :discounted_rates 
  #   xit 'return correct types' do
  #     request.headers.merge! user_auth_headers
  #     body = { 'rate' => '0.23' } 
  #     post :create, params: body, :format => :json
  #     expect_status(200)
  #     expect_json_types('rate',  rate: :float)
  #   end
  # end
end 
RSpec.describe 'Rates API', type: :request do
    let!(:discounted_rates) { create_list(:discounted_rate, 10) }
    let(:discounted_rate_id) { discounted_rates.first.id }
  
    let(:user) { create(:user) }
    let(:user_auth_headers) { user.create_new_auth_token }
    let(:valid_attributes) { {rate_id: discounted_rate_id , rate: '0.23' }}
    
    describe 'PUT /api/rates/update?${valid_attributes} ' do
      context 'when the record exists' do 
        before { 
          # byebug
          put "/api/rates/update", params: valid_attributes, headers: user_auth_headers  }
        it 'updates the record' do
          expect(response.body).to be_empty
        end
        it 'return status code 204' do 
          expect_status 204
        end
      end
    end
  
    # describe 'DELETE /api/rates/:id' do
    #   before { 
    #     delete "/api/rates/#{discounted_rate_id}.json", params: {}, headers: user_auth_headers }
    #   xit 'return status code 200' do 
    #     expect_status 200
    #   end
    # end
end
