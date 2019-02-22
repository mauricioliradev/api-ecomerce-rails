# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  it { should belong_to(:order) }
  it { should belong_to(:product) }

  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:sold_price) }
end
