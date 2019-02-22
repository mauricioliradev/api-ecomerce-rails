# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20_190_218_201_654) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'order_items', force: :cascade do |t|
    t.bigint 'order_id', null: false
    t.bigint 'product_id', null: false
    t.integer 'amount', null: false
    t.float 'sold_price', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_order_items_on_order_id'
    t.index ['product_id'], name: 'index_order_items_on_product_id'
  end

  create_table 'orders', force: :cascade do |t|
    t.string 'code', null: false
    t.datetime 'buy_date', null: false
    t.string 'status'
    t.float 'freight_value', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'buyer'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'code', null: false
    t.string 'name', null: false
    t.string 'description', null: false
    t.integer 'stock', null: false
    t.float 'price', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'customizable_attributes'
  end

  add_foreign_key 'order_items', 'orders'
  add_foreign_key 'order_items', 'products'
end
