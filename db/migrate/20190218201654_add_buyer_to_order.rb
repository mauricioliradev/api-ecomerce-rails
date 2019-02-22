# frozen_string_literal: true

class AddBuyerToOrder < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :buyer, :string
  end
end
