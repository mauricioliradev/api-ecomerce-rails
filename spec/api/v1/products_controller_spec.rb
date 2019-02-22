# frozen_string_literal: true

require 'rails_helper'
require 'json'

class ProductsControllerTest < ActionController::TestCase
  product_params = { "product":
      {
        "code": '54657987',
        "name": 'Notebook Sansumg',
        "price": '1100.89',
        "stock": '5',
        "description": 'i5-7200U 8GB 1TB Tela 15.6” Windows 10 Expert NP350XAA-JD1BR',
        "customizable_attributes": 'preto, branco, sinza'
      } }

  describe 'CRUD' do
    describe 'Create product' do
      it 'Gets a 201 http response' do
        post api_v1_products_path, params: product_params
        expect(response).to have_http_status(201)
      end

      it 'Creates a new product in the database' do
        # create a new code to test
        product_params[:product][:code] = '87965'

        number_of_products = Product.count
        post api_v1_products_path, params: product_params
        expect(Product.count).to eq (number_of_products + 1)
      end
    end

    describe 'Show product' do
      it 'Gets a 200 http response' do
        product = Product.first
        get api_v1_product_path(product)
        expect(response).to have_http_status(200)
      end

      it 'Shows the first product' do
        product = Product.first
        get api_v1_product_path(product)
        expect(JSON.parse(response.body)['id']).to eq product.id
      end
    end

    describe 'Products Index' do
      it 'Gets a 200 http response' do
        get api_v1_products_path

        expect(response).to have_http_status(200)
      end

      it 'Gets an array as response' do
        get api_v1_products_path
        json_response = JSON.parse(response.body)

        expect(json_response.class).to eq Array
      end

      it 'Array contains all objects' do
        get api_v1_products_path
        json_response = JSON.parse(response.body)
        expect(json_response.count).to eq Product.count
      end
    end

    describe 'Update product' do
      new_params = { "product":
          {
            "code": '7892',
            "name": 'Notebook acer',
            "price": '2100.89',
            "stock": '5',
            "description": 'i3-7200U 8GB 1TB Tela 15.6” Linux',
            "customizable_attributes": 'preto, branco, sinza'
          } }

      it 'Gets a 200 http response' do
        last = Product.last
        put api_v1_product_path(last), params: new_params

        expect(response).to have_http_status(200)
      end

      it 'Returns the updated object' do
        last = Product.last
        patch api_v1_product_path(last), params: new_params

        json_response = JSON.parse(response.body)

        expect(json_response['name']).to eq 'Notebook acer'
      end
    end

    describe 'Delete product' do
      it 'Gets a 204 (no content) http response' do
        product = Product.last
        delete api_v1_product_path(product)
        expect(response).to have_http_status(204)
      end

      it 'Deletes the last product form the DB' do
        product = Product.last
        delete api_v1_product_path(product)
        expect(Product.last == product).to eq false
      end
    end
  end
end
