require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
    let(:user) { create(:user) }
    let(:user_auth_headers) { user.create_new_auth_token }
    describe 'GET index' do
        render_views
        it 'return correct data' do 
            request.headers.merge! user_auth_headers
            expect_status(200)
        end
    end 
end
RSpec.describe 'Dashboards API', type: :request do
    let(:user) { create(:user) }
    let(:user_auth_headers) { user.create_new_auth_token }
  
    describe 'GET /api/dashboards' do 
      before { 
        get "/api/dashboards.json", params: {}, headers: user_auth_headers 
      }
  
      context 'when the record not exists ' do
  
        it 'returns status code 200' do
          expect_status 200
        end
  
        it 'returns result' do
          expect(response.body).to match(/result/)
        end
      end
    end

  end