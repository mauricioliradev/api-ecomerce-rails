# frozen_string_literal: true

class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
      t.belongs_to :order, foreign_key: true, null: false
      t.belongs_to :product, foreign_key: true, null: false
      t.integer :amount, null: false
      t.float :sold_price, null: false
      t.timestamps
    end
  end
end
