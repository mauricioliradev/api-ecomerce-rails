# frozen_string_literal: true

FactoryBot.define do
  factory :order_items do
    amount { rand(20..40) }
    sold_price { rand(1.0..100.0).round(2) }
    product { nil }
    order { nil }
  end
end
