# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Order, type: :model do
  it { should have_many(:order_items).dependent(:destroy) }

  it { should validate_presence_of(:buyer) }
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:buy_date) }
  it { should validate_presence_of(:freight_value) }
end
