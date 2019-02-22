# frozen_string_literal: true

require 'rails_helper'
require 'json'

class OrdersControllerTest < ActionController::TestCase
  order_params = { "order":
      {
        "code": '80025577',
        "buy_date": '2019-02-19',
        "status": 'pendente',
        "freight_value": 37.23,
        "buyer": 'Benjamin Button',
        "order_items_attributes": [
          {
            "product_id": 1,
            "amount": 2,
            "sold_price": 1.35
          },
          {
            "product_id": 2,
            "amount": 4,
            "sold_price": 5.09
          }
        ]
      } }

  orders_params_two = [
    {
      "product_id": 1,
      "amount": 2,
      "sold_price": 1.35
    },
    {
      "product_id": 2,
      "amount": 4,
      "sold_price": 5.09
    }
  ]

  describe 'CRUD' do
    describe 'Create order' do
      it 'Gets a 201 http response' do
        post api_v1_orders_path, params: order_params
        expect(response).to have_http_status(201)
      end

      it 'Creates a new order in the database' do
        # creates a new code to test the params
        order_params[:order][:code] = '987654'

        number_of_orders = Order.count
        post api_v1_orders_path, params: order_params

        # finds all items in database
        expect(Order.count).to eq (number_of_orders += 1)
      end

      it 'Decreases stock for an ordered product' do
        # changes params to include a new code
        order_params[:order][:code] = '789652568'

        product_id = order_params[:order][:order_items_attributes].first[:product_id].to_i
        ordered_product = Product.find(product_id)
        initial_stock = ordered_product.stock
        amount_ordered = order_params[:order][:order_items_attributes].first[:amount]

        post api_v1_orders_path, params: order_params

        new_stock = Product.find(product_id).stock

        # check that stock has decreased
        expect(new_stock).to eq (initial_stock - amount_ordered)
      end

      it 'Does not create order if product has not been registered' do
        # changes params to include a new code
        order_params[:order][:code] = '000111'
        # remove params order_items
        order_params[:order][:order_items_attributes] = []

        post api_v1_orders_path, params: order_params

        expect(JSON.parse(response.body)['error']).to eq 'Order must contain items.'
      end

      it 'Does not create order if product does not have enough stock' do
        # changes params to include a new code
        order_params[:order][:code] = '9856356'
        order_params[:order][:order_items_attributes] = orders_params_two

        # changes params to use the last product created
        order_params[:order][:order_items_attributes][0][:product_id] = Product.last.id

        # changes amount to a value greater than the stock of the last product
        order_params[:order][:order_items_attributes].first[:amount] = Product.last.stock += 1

        post api_v1_orders_path, params: order_params

        expect(JSON.parse(response.body)['status']).to eq 204
      end
    end

    describe 'Show order' do
      it 'Gets a 200 http response' do
        order = Order.last
        get api_v1_order_path(order)
        expect(response).to have_http_status(201)
      end
    end

    describe 'Orders Index' do
      it 'Gets a 200 http response' do
        get api_v1_orders_path
        expect(response).to have_http_status(200)
      end

      it 'Gets an array as response' do
        get api_v1_orders_path
        json_response = JSON.parse(response.body)

        expect(json_response.class).to eq Array
      end

      it 'Array contains all objects' do
        get api_v1_orders_path
        json_response = JSON.parse(response.body)

        expect(json_response.count).to eq Order.count
      end
    end

    describe 'Update order' do
      new_params = { "order":
          {
            "code": '7896546333',
            "buyer": 'Artur Cury',
            "buy_date": '2019-02-20',
            "status": 'cancelado',
            "freight_value": 20.0,
            "order_items_attributes": [
              {
                "product_id": 1,
                "amount": 2,
                "sold_price": 1.35
              },
              {
                "product_id": 2,
                "amount": 4,
                "sold_price": 5.09
              }
            ]
          } }

      it 'Gets a 500 http response' do
        order = Order.last
        put api_v1_order_path(order), params: new_params

        expect(response).to have_http_status(500)
      end

      it 'Updates the last order' do
        order = Order.last
        put api_v1_order_path(order), params: new_params

        json_response = JSON.parse(response.body)

        json_response['status'] == new_params[:order][:status]
      end
    end

    describe 'Delete order' do
      it 'Gets a 204 (no content) http response' do
        order = Order.last
        delete api_v1_order_path(order)
        expect(response).to have_http_status(204)
      end

      it 'Deletes the last order from the DB' do
        initial_amount_of_orders = Order.count
        order = Order.last

        delete api_v1_order_path(order)
        expect(Order.count).to eq (initial_amount_of_orders - 1)
      end
    end
  end
end
