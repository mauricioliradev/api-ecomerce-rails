# frozen_string_literal: true

class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.string :code, null: false
      t.datetime :buy_date, null: false
      t.string :status
      t.float :freight_value, null: false

      t.timestamps
    end
  end
end
