# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :code, null: false
      t.string :name, null: false
      t.string :description, null: false
      t.integer :stock, null: false
      t.float :price, null: false

      t.timestamps
    end
  end
end
