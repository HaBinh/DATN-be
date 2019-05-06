require 'rails_helper'

RSpec.describe 'ProductDiscoutedrates API', type: :request do
    let!(:product_discounted_rate) { create(:product_discounted_rate) }
    let(:product_discounted_rate_id) { product_discounted_rate.id }
    # let(:product_id) { product_discounted_rate.product_id }

    let(:user) { create(:user) }
    let(:user_auth_headers) { user.create_new_auth_token }
    let(:valid_attributes) { {rate: '0.23' }}

    describe 'GET /api/product_discoutedrates ' do 
    before { 
      get "/api/product_discoutedrates.json", params: {}, headers: user_auth_headers 
    }
    context 'when the record not exists ' do
      it 'returns status code 200' do
        expect_status 200
      end

      it 'returns a not found message' do
        expect(response.body).to match(/discounted_rates/)
      end
    end
    end
    
    describe 'PUT /api/product_discoutedrates/:id?${valid_attributes} ' do
      context 'when the record exists' do 
        before { 
            put "/api/product_discoutedrates/#{product_discounted_rate_id}?", params: valid_attributes, headers: user_auth_headers             
        }
        it 'updates the record' do
          expect(response.body).not_to be_empty
        end
        it 'return status code 204' do 
          expect_status 200
        end
      end
    end
end