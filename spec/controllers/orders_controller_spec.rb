require 'rails_helper'

RSpec.describe 'Orders API', type: :request do

  # let!(:order) { create(:order) }
  # let(:order_id) { order.id }
  # let!(:order_item) { create(:order_item, order_id: order_id, quantity: 2) }

  let!(:customer) { create(:customer) }
  let(:customer_id) { customer.id } 

  let!(:product) { create(:product) }
  let(:product_id) { product.id }

  let!(:import) { create(:import, :product_id => product_id) } 
  # import co 10 hang trong kho va chua ban cai nao ca
  let!(:import_2) { create(:import, :product_id => product_id, quantity_sold: 0)}
  

  let!(:articles) { create_list(:article, 10, product_id: product_id)}
  let(:status) { 'exist' }
  let(:price_sale) { 2000 }
  let(:quantity) { 1 }
  let(:quantity_1) { 1 } 
  let(:quantity_12) { 12 } 
  let(:not_enough_quantity) { 1000 }
  let(:discounted_rate) { 0 }

  let(:attr_for_customer) { attributes_for(:customer) }

  let(:total_amount) { price_sale * quantity }
  let(:customer_paid_fully) { 1000000 }
  let(:customer_NOT_fully_paid) { 1 }

  let(:user) { create(:user) }
  let(:user_auth_headers) { user.create_new_auth_token } 
  let(:payment) { 1 }        

  describe 'POST /orders' do

    let(:valid_params) { { 
        order: { 
          customer_id: customer_id,  
          customer_paid: customer_paid_fully
        },
        order_items: [
          {
            product_id: product_id,
            quantity: quantity_1,
            price_sale: price_sale,
            discounted_rate: discounted_rate
          }
        ]
      } 
    }

    let(:params_with_quantity_10) { { 
        order: { 
          customer_id: customer_id,  
          customer_paid: customer_paid_fully
        },
        order_items: [
          {
            product_id: product_id,
            quantity: quantity_12,
            price_sale: price_sale,
            discounted_rate: discounted_rate
          }
        ]
      } 
    }

    let(:valid_params) { { 
        order: { 
          customer_id: customer_id,  
          customer_paid: customer_paid_fully
        },
        order_items: [
          {
            product_id: product_id,
            quantity: quantity_1,
            price_sale: price_sale,
            discounted_rate: discounted_rate
          }
        ]
      } 
    }

    let(:paid_am1) { { 
        order: { 
          customer_id: customer_id,  
          customer_paid: -1
        },
        order_items: [
          {
            product_id: product_id,
            quantity: quantity,
            price_sale: price_sale,
            discounted_rate: discounted_rate
          }
        ]
      } 
    }

    let(:quantity_less_than_0) { { 
        order: { 
          customer_id: customer_id,  
          customer_paid: 1
        },
        order_items: [
          {
            product_id: product_id,
            quantity: -1,
            price_sale: price_sale,
            discounted_rate: discounted_rate
          }
        ]
      } 
    }

    let(:not_fully_paid_params) { { 
      order: { 
        customer_id: customer_id,  
        customer_paid: customer_NOT_fully_paid
      },
      order_items: [
        {
          product_id: product_id,
          quantity: quantity,
          price_sale: price_sale,
          discounted_rate: discounted_rate
        }
      ]
      } 
    }

    let(:unvalid_params) { { 
        order: { 
          customer_id: customer_id,  
          customer_paid: customer_paid_fully
        },
        order_items: [
          {
            product_id: product_id,
            quantity: not_enough_quantity,
            price_sale: price_sale,
            discounted_rate: discounted_rate
          }
        ]
      } 
    }

    let(:new_customer_params) { {
      order: {
        name: 'Thuan', 
        phone: '01237546997',
        customer_paid: customer_paid_fully
      },
      order_items: [
        {
          product_id: product_id,
          quantity: quantity,
          price_sale: price_sale,
          discounted_rate: discounted_rate
        }
      ]
    }}

    describe 'with customer paid < -1' do
      before { 
        post "/api/orders", params: paid_am1, headers: user_auth_headers 
      }
      
      it 'return status 422' do 
        expect_status 422
      end
  
      it 'return correct types' do 
        expect_json(key_message: regex("customer_paid_greater_than_1"))
      end
    end

    describe 'with quantity <= 0' do 
      before { 
        post "/api/orders", params: quantity_less_than_0, headers: user_auth_headers 
      }
      
      it 'return status 422' do 
        expect_status 422
      end
  
      it 'return correct types' do 
        expect_json(key_message: regex("quantity_greater_than0"))
      end
    end
    describe 'with valid params' do 
      before { 
        @before_order_count = Order.count
        @before_order_item  = OrderItem.count
        post "/api/orders", params: valid_params, headers: user_auth_headers 
      }
      
      it 'return status 201' do 
        expect_status 201
      end
  
      it 'return correct types' do 
        expect_json_types('order',
                                   total_amount: :float, 
                                   customer_paid: :float, 
                                   fully_paid: :boolean)
        expect_json('order', { :customer_id => customer_id, 
                               :total_amount => price_sale * quantity,
                               fully_paid: true })
      end
  
      it 'should add complete ' do 
        expect(Order.count).not_to eq(@before_order_count)
        expect(OrderItem.count).not_to eq(@before_order_item)
        #trong kho da ban 4 ban di 1 thi trong kho tang len da ban la 5
        import.reload()
        expect(import.quantity_sold).to eq(5)
      end
    end
    describe 'with params sold 12 quantity' do 
      before { 
        @before_order_count = Order.count
        @before_order_item  = OrderItem.count
        post "/api/orders", params: params_with_quantity_10, headers: user_auth_headers 
      }
      
      it 'return status 201' do 
        expect_status 201
      end
  
      it 'return correct types' do 
        expect_json_types('order',
                                   total_amount: :float, 
                                   customer_paid: :float, 
                                   fully_paid: :boolean)
        expect_json('order', { :customer_id => customer_id, 
                               :total_amount => price_sale * quantity_12,
                               fully_paid: true })
      end
  
      it 'should add complete ' do 
        expect(Order.count).not_to eq(@before_order_count)
        expect(OrderItem.count).not_to eq(@before_order_item)
        import.reload()
        import_2.reload()
        expect(import.quantity_sold).to eq(10)
        expect(import_2.quantity_sold).to eq(6)
      end
    end

    describe 'with unvalid params ( not enough quantity )' do 
      before { 
        @before_order_count = Order.count
        @before_order_item  = OrderItem.count
        post "/api/orders", params: unvalid_params, headers: user_auth_headers 
      }

      it 'return status 422' do 
        expect_status 422
      end

      it 'return message show instruction not enough quantity' do 
        expect_json(key_message: regex("not-enough-quantity"))
      end

      it 'cannot create order' do 
        expect(Order.count).to eq(@before_order_count)
      end
    end

    describe 'with new customer' do 
      before {
        @before_customer_count
        post "/api/orders", params: new_customer_params, headers: user_auth_headers 
      }

      it 'Should create new customer' do 
        expect(Customer.count).not_to eq(@before_customer_count)
      end

      it 'return correct types' do 
        expect_json_types('order',
                                   total_amount: :float, 
                                   customer_paid: :float, 
                                   fully_paid: :boolean)
        expect_json('order', { :customer_id => customer_id + 1, 
                               :total_amount => price_sale * quantity,
                               fully_paid: true })
      end
  
      it 'should add complete ' do 
        expect(Order.count).not_to eq(@before_order_count)
        expect(OrderItem.count).not_to eq(@before_order_item)
      end
    end

    describe 'with not fully paid params' do 
      before {
        post "/api/orders", params: not_fully_paid_params, headers: user_auth_headers 
      }

      it 'should return correct types' do 
        expect_json_types('order',
        total_amount: :float, 
        customer_paid: :float, 
        fully_paid: :boolean)
      end

      it 'should returrn correct customer paid' do 
        expect_json('order', { customer_paid: customer_NOT_fully_paid,
                               fully_paid: false})
      end
    end

  end

  describe 'GET /api/orders' do 

    let(:valid_params) { { 
        order: { 
          customer_id: customer_id,  
          customer_paid: customer_paid_fully
        },
        order_items: [
          {
            product_id: product_id,
            quantity: quantity,
            price_sale: price_sale,
            discounted_rate: discounted_rate
          }
        ]
      } 
    }
    before { 
      post "/api/orders", params: valid_params, headers: user_auth_headers 
      get "/api/orders.json", params: {}, headers: user_auth_headers }

    it 'return status 200' do 
      expect_status 200 
    end

    it 'return correct types' do 
      expect_json_types(orders: :array_of_objects)
    end
  end

  describe 'GET /api/orders/:id' do 
    let(:valid_params) { { 
        order: { 
          customer_id: customer_id,  
          customer_paid: customer_paid_fully
        },
        order_items: [
          {
            product_id: product_id,
            quantity: quantity,
            price_sale: price_sale,
            discounted_rate: discounted_rate
          }
        ]
      } 
    }
    before { 
      post "/api/orders", params: valid_params, headers: user_auth_headers 
      order_id = Order.last.id
      get "/api/orders/#{order_id}.json", params: {}, headers: user_auth_headers
    }

    it 'return status 200' do 
      expect_status 200
    end

    it 'return order correct types' do 
      expect_json_types('order', total_amount: :float, 
                                 debt: :float,
                                 fully_paid: :boolean,
                                 customer: :object, 
                                 order_items: :array_of_objects)
    end

    it 'return correct data order' do 
      expect_json('order', total_amount: quantity * price_sale, 
                           fully_paid: true,
                           customer_paid: customer_paid_fully,
                           debt: 0)
    end

    it 'return correct customer data' do 
      expect_json('order.customer', name: customer.name, 
                                          phone: customer.phone)
    end

    it 'return correct customer types' do 
      expect_json_types('order.customer', name: :string, 
                                          phone: :string, 
                                          email: :string_or_null)
    end

    it 'correct types order items' do 
      expect_json('order.order_items.0', amount: quantity * price_sale,
                                         quantity: quantity,
                                         discounted_rate: discounted_rate,
                                         product_id: product_id)
    end

    it 'correct types order items' do 
      expect_json_types('order.order_items.*', amount: :float,
                                               quantity: :integer,
                                               discounted_rate: :float)
    end

    it 'correct types product in order items' do 
      expect_json_types('order.order_items.*.product', name: :string, 
                                                       code: :string,
                                                       default_imported_price: :float,
                                                       default_sale_price: :float)
    end
  end

  describe 'PUT /api/orders/:id ( pay debt )' do 
    let(:not_fully_paid_params) { { 
      order: { 
        customer_id: customer_id,  
        customer_paid: customer_NOT_fully_paid
      },
      order_items: [
        {
          product_id: product_id,
          quantity: quantity,
          price_sale: price_sale,
          discounted_rate: discounted_rate
        }
      ]
      } 
    }

    before {
      post "/api/orders", params: not_fully_paid_params, headers: user_auth_headers 
      order_id = Order.last.id 
      put "/api/orders/#{order_id}.json", params: { payment: payment }, headers: user_auth_headers 
    }

    it 'should return correct types' do 
      expect_json_types('order', customer_paid: :float, 
                                 total_amount: :float, 
                                 fully_paid: :boolean,
                                 debt: :float) 
    end

    it 'should returrn correct data' do 
      expect_json('order', customer_paid: customer_NOT_fully_paid + payment, 
                           debt: total_amount - customer_NOT_fully_paid - payment,
                           fully_paid: false, 
                           total_amount: total_amount)
    end
  end

  describe 'Test return order ' do 
    context ' with fully paid ' do 
      let(:quantity) { 12 }
      let(:quantity_return) { 11 }
      let(:not_fully_paid_params) { { 
        order: { 
          customer_id: customer_id,  
          customer_paid: price_sale * quantity
        },
        order_items: [
          {
            product_id: product_id,
            quantity: quantity,
            price_sale: price_sale,
            discounted_rate: discounted_rate
          }
        ]
        } 
      }

      let(:order_item_id) { 1 }
      
      before {
        post "/api/orders", params: not_fully_paid_params, headers: user_auth_headers 
        order_id = Order.last.id 
        order_item_id = Order.last.order_items.first.id 
        return_params =  {
              order_items: [
                {
                  id: order_item_id,
                  quantity_return: quantity_return
                }
              ]
            }
        put "/api/return-order/#{order_id}.json", params: return_params, headers: user_auth_headers
      }

      it 'should return correct data' do 
        expect_json('order', total_amount: price_sale * (quantity - quantity_return),
                            paid_return_user: price_sale * quantity_return )
      end

      it 'check import' do 
        import_2.reload
        import.reload
        expect(import_2.quantity_sold).to eq(0)
        expect(import.quantity_sold).to eq(5)
      end
    end

    context 'with user debt and return product but still in debt :))' do 
      let(:quantity) { 3 }
      let(:quantity_return) { 1 }
      let(:not_fully_paid_params) { { 
        order: { 
          customer_id: customer_id,  
          customer_paid: 1
        },
        order_items: [
          {
            product_id: product_id,
            quantity: quantity,
            price_sale: price_sale,
            discounted_rate: discounted_rate
          }
        ]
        } 
      }

      let(:order_item_id) { 1 }
      
      before {
        post "/api/orders", params: not_fully_paid_params, headers: user_auth_headers 
        order_id = Order.last.id 
        order_item_id = Order.last.order_items.first.id 
        return_params =  {
              order_items: [
                {
                  id: order_item_id,
                  quantity_return: quantity_return
                }
              ]
            }
        put "/api/return-order/#{order_id}.json", params: return_params, headers: user_auth_headers
      }

      it 'should return correct data' do 
        expect_json('order', total_amount: price_sale * (quantity - quantity_return),
                            paid_return_user: 0,
                            debt: price_sale * (quantity - quantity_return) - 1 )
      end
    end

    context 'with user buy one product and return that one ' do 
      let(:quantity) { 1 }
      let(:quantity_return) { 1 }
      let(:not_fully_paid_params) { { 
        order: { 
          customer_id: customer_id,  
          customer_paid: price_sale * quantity 
        },
        order_items: [
          {
            product_id: product_id,
            quantity: quantity,
            price_sale: price_sale,
            discounted_rate: discounted_rate
          }
        ]
        } 
      }

      let(:order_item_id) { 1 }
      
      before {
        post "/api/orders", params: not_fully_paid_params, headers: user_auth_headers 
        order_id = Order.last.id 
        order_item_id = Order.last.order_items.first.id 
        return_params =  {
              order_items: [
                {
                  id: order_item_id,
                  quantity_return: quantity_return
                }
              ]
            }
        put "/api/return-order/#{order_id}.json", params: return_params, headers: user_auth_headers
      }

      it 'should return correct data' do 
        expect_json('order', total_amount: 0,
                            paid_return_user: price_sale * quantity,
                            debt: 0 )
      end

      it 'order has no order items' do 
        expect(Order.last.order_items.count).to equal(0)
        expect(Order.last.total_amount).to eq(0)
      end
    end
  end


  describe 'cannot find order' do 
    before {
      get "/api/orders/#{1}", headers: user_auth_headers
    }

    it 'should return 404' do
      expect_status 404
    end

    it 'should return correct message' do
      expect_json('message', 'Not found')
    end 
  end
end
