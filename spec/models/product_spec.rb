# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should have_many(:order_items).dependent(:destroy) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:stock) }
  it { should validate_presence_of(:price) }
end
