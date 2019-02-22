# frozen_string_literal: true

class AddCustomizableAttributesToProduct < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :customizable_attributes, :string
  end
end
