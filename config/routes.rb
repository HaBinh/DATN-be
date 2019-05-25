Rails.application.routes.draw do

  scope '/api' do
    mount_devise_token_auth_for 'User', at: 'auth', controllers: {
      registrations: 'user/registrations',
      sessions: 'user/sessions'
    }
    
    resources :users, only: [:index, :update, :destroy]
    get 'search-orders', to: 'orders#search'
    put 'return-order/:id', to: 'orders#return_order'
    post 'quote-price', to: 'orders#quote'
    resources :customers
    resources :products do 
      get 'category', to: 'products#get_category'
    end
    get '/add_storage', to: 'products#addStorage'
    resources :orders
    resources :articles
    resources :categories
    resources :category_discounts
    resources :stores
    resources :dashboards
    put 'articles/update', to: 'articles#update'
    resources :rates, only: [:index, :update]
    resources :product_discoutedrates
    put 'rates/update',                 to: 'rates#update'
    get '/get_products',                to: 'stores#get_products'
    get '/customers_in_debt',           to: 'customers#get_in_debt'
    put 'pay_total_debt/:customer_id',  to: 'orders#pay_total_debt'
    put 'change',                       to: 'product_discoutedrates#change'
    get '/get_inventory_statistics',    to: 'stores#get_inventory_statistics'
    get '/products_best_seller',        to: 'orders#products_best_seller'
  end
  get '*path' => redirect('/')
end
