# frozen_string_literal: true

class Api::V1::ReportsController < Api::V1::ApiController
  def ticket
    @start_date = params[:start_date]
    @end_date = params[:end_date]

    # get order in range date
    orders = Order.where(buy_date: DateTime.parse(@start_date).beginning_of_day..DateTime.parse(@end_date).end_of_day)
    @orders_count = orders.count

    if @orders_count == 0
      @revenues = 0
      @average_ticket = 0
      @response = { start_date: @start_date, end_date: @end_date, number_of_orders: @orders_count, total_revenue: @revenues, average_ticket: @average_ticket }
      render json: @response, status: :success
    else
      @revenues = get_total_revenue(orders)
      @average_ticket = (@revenues / @orders_count.to_f).round(2)
      @response = { start_date: @start_date, end_date: @end_date, number_of_orders: @orders_count, total_revenue: @revenues, average_ticket: @average_ticket }
      render json: @response, status: :success
    end
  end

  private

  def get_total_revenue(orders)
    total_revenue = 0
    frete = 0
    orders.each do |order|
      # get freigth value
      frete += order.freight_value
      # get total recipe revenue : amount x sold_price
      order.order_items.each do |item|
        total = item.amount * item.sold_price
        total_revenue += total
      end
    end
    (total_revenue + frete).round(2)
  end
end
