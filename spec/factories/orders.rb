# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    buyer { Faker::FunnyName.name }
    code { rand(0..100).to_s }
    buy_date { Faker::Date.between(1.month.ago, Date.today) }
    freight_value { rand(10.0..40.0).round(2) }
    order_items { nil }
  end
end
