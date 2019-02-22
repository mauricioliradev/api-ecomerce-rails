# frozen_string_literal: true

class Order < ApplicationRecord
  ### RELATIONSHIPS
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items

  ### VALIDATIONS
  validates :buyer, :code, :buy_date, :freight_value, presence: true
  validates :code, uniqueness: true
  accepts_nested_attributes_for :order_items, allow_destroy: true

  ##### CALLBACKS
  before_save :set_before_save

  private

  # decrementar o stock a cada pedido
  def set_before_save
    order_items.each do |item|
      product = Product.find(item.product_id)
      new_stock = product.stock - item.amount
      product.update_attribute(:stock, new_stock)
    end
  end
end
