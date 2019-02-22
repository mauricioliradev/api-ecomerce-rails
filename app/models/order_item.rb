# frozen_string_literal: true

class OrderItem < ApplicationRecord
  ### RELATIONSHIPS
  belongs_to :order
  belongs_to :product

  ### VALIDATIONS
  validates :product_id, :amount, :sold_price, presence: true
end
