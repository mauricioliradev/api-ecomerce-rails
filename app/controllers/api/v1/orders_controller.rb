# frozen_string_literal: true

class Api::V1::OrdersController < Api::V1::ApiController
  before_action :set_order, only: %i[show update destroy]

  # GET /api/v1/orders
  def index
    @orders = Order.all
    render json: @orders, include: :order_items
  end

  # GET /api/v1/orders/:id
  def show
    render json: @order, include: :order_items, status: :created
  end

  # POST /api/v1/orders
  def create
    @order = Order.new(order_params)
    # Recusar a criação de um pedido com item não cadastrado;
    if order_params[:order_items_attributes].present?
      # Evitar o cadastro de pedidos cujo item não tem estoque suficiente.
      if verify_stok(order_params[:order_items_attributes]).empty?
        if @order.save
          render json: @order, include: :order_items, status: :created
        else
          render json: @order.errors, status: :unprocessable_entity
          end
      else
        render json: { error: "No enough stock for #{verify_stok(order_params[:order_items_attributes])}", status: 204 }
      end
    else
      render json: { error: 'Order must contain items.', status: 400 }
    end
  end

  # PATCH/PUT /api/v1/orders/:id
  def update
    # Recusar a atualização de um pedido com item não cadastrado;
    if order_params[:order_items_attributes].present?
      if verify_stok(order_params[:order_items_attributes]).empty?
        # update order
        if @order.update(code: order_params[:code], buyer: order_params[:buyer], buy_date: order_params[:buy_date], status: order_params[:status], freight_value: order_params[:freight_value])
          # update items
          order_params[:order_items_attributes].each_with_index do |_o, index|
            @order.order_items[index].update(product_id: order_params[:order_items_attributes][index][:product_id], amount: order_params[:order_items_attributes][index][:amount], sold_price: order_params[:order_items_attributes][index][:sold_price])
          end
          render json: @order, include: :order_items, status: :updated
        else
          render json: @order.errors, status: :unprocessable_entity
        end
      else
        render json: { error: "No enough stock for #{verify_stok(order_params[:order_items_attributes])}", status: 204 }
      end
    else
      render json: { error: 'Order must contain items.', status: 400 }
    end
  end

  def destroy
    if @order.destroy
      # if successfully deleted, will render empty response
      head :no_content
    else
      render json: @order.errors, status: :unprocessable_entity
  end
  end

  def verify_stok(order_items)
    arr_product = []
    order_items.each do |item|
      product = Product.find(item['product_id'])
      arr_product << product.name if product.stock.to_f < item['amount'].to_f
    end
    arr_product
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def order_params
    params.require(:order).permit(:code, :buyer, :buy_date, :status, :freight_value, order_items_attributes: %i[id product_id amount sold_price _destroy])
  end
end
