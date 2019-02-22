# frozen_string_literal: true

class Product < ApplicationRecord
  ### RELATIONSHIPS
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items
  ### VALIDATIONS
  validates :name, :code, :description, :stock, :price, presence: true
  validates :code, uniqueness: true
end
