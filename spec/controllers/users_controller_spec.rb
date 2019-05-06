require 'rails_helper'

RSpec.describe 'User API', type: :request do
    let(:admin) { create(:user, :role => "manager") }
    let(:admin_auth_headers) { admin.create_new_auth_token } 

    let(:user) { create(:user) }
    let(:user_auth_headers) { user.create_new_auth_token } 

    describe 'get all users' do
        context 'not manager' do 
            before { 
                get '/api/users', params: {}, headers: user_auth_headers
            }

            it 'should not process status' do 
                expect_status 422
            end

            it 'should render right message' do 
                expect_json('message', "You are not manager")
            end
        end 

        context 'with user is manager' do 
            before { 
                get '/api/users.json', params: {}, headers: admin_auth_headers
            }

            it 'should get success' do 
                expect_status 200
            end

            it 'return all users' do 
                expect_json('users.0', { :id => admin.id, :name => admin.name })            
            end


        end
    end

    let(:new_user_params) { {
        email: 'thuan274@gmail.com',
        name: 'thuan',
        password: 'thuan274',
        password_confirmation: 'thuan274'
    }}

    describe 'test add new user' do 
       before {
           post '/api/auth.json', params: new_user_params, headers: admin_auth_headers
       } 

        it 'should add new user' do 
            new_user = User.last
            expect(new_user.name).to eq('thuan')
        end
    end

    describe 'test remove or reactive user' do 
        before {
            delete "/api/users/#{user.id}.json", params: {}, headers: admin_auth_headers
        }

        it 'should change active user' do 
            expect(User.first.active).to be(false)
        end
    end

    let(:valid_update_params) {{
      name: 'thuan274',
      role: 'manager'
    }}

    describe 'test update info user' do 
      before {
        put "/api/users/#{user.id}.json", params: valid_update_params, headers: admin_auth_headers
      }

      it 'should update success new info to user' do 
        user = User.first 
        expect(user.name).to eq("thuan274")
        expect(user.isManager).to be(true)
      end
    end

    

end
