# frozen_string_literal: true

FactoryBot.define do
  factory :product do
    code { rand(0..100).to_s }
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentences }
    stock { rand(20..40) }
    price { rand(1.0..100.0).round(2) }
    customizable_attributes { Faker::Lorem.words(4).join(', ') }
    orders { nil }
  end
end
