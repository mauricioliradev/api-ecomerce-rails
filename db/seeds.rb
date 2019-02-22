# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# create product
puts 'Creating products...'
14.times do |i|
  product = Product.create!(
    code: "#{rand(0..100)}#{i}",
    name: Faker::Commerce.product_name,
    description: Faker::Lorem.sentences,
    stock: rand(20..40),
    price: rand(1.0..100.0).round(2),
    customizable_attributes: Faker::Lorem.words(4).join(', ')
  )
end
puts 'Products created!'

puts 'Creating orders...'
8.times do |i|
  order = Order.create!(
    code: "#{rand(0..100)}#{i}",
    buy_date: Faker::Date.between(1.month.ago, Date.today),
    buyer: Faker::FunnyName.name,
    status: %w['aprovado entregue cancelado'].sample,
    freight_value: rand(10.0..40.0).round(2),
    order_items: [
      OrderItem.new(product_id: Product.find(i + 1).id, amount: rand(2..10), sold_price: rand(1.0..50.0).round(2)),
      OrderItem.new(product_id: Product.find((i + 2)).id, amount: rand(2..10), sold_price: rand(1.0..50.0).round(2))
    ]
  )
end
puts 'Orders created!'
