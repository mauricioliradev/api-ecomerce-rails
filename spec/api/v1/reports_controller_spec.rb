# frozen_string_literal: true

require 'rails_helper'
require 'json'

class ReportsControllerTest < ActionController::TestCase
  report_params = {
    "start_date": '2019-01-01',
    "end_date": '2019-02-20'
  }

  describe 'Report' do
    describe 'Read the report' do
      it 'Gets a 500 http response' do
        post api_v1_reports_path, params: report_params
        expect(response).to have_http_status(500)
      end

      it 'Includes average ticket' do
        post api_v1_reports_path, params: report_params
        json_response = JSON.parse(response.body)
        expect(json_response).to include 'average_ticket'
      end

      it 'Calculates the correct average ticket' do
        start_date = report_params[:start_date]
        end_date = report_params[:end_date]

        orders_by_period = Order.where(buy_date: DateTime.parse(start_date).beginning_of_day..DateTime.parse(end_date).end_of_day)
        count_orders = orders_by_period.count

        if count_orders == 0
          average_ticket = 0
        else
          total_revenue = 0
          frete = 0

          orders_by_period.each do |order|
            # get freigth value
            frete += order.freight_value

            # item in all orders
            order.order_items.each do |item|
              total = item.amount * item.sold_price
              total_revenue += total
            end
          end
          # round(2) gives two decimal points
          average_ticket = ((total_revenue + frete).round(2) / count_orders.to_f).round(2)
        end

        post api_v1_reports_path, params: report_params
        reported_average_ticket = (JSON.parse(response.body)['average_ticket']).to_f
        expect(reported_average_ticket).to eq average_ticket
      end
    end
  end
end
