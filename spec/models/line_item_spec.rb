# frozen_string_literal: true

require 'app_helper'
require 'bigdecimal'
RSpec.describe LineItem do
  let(:checkout_item_misc) { CheckoutItem.new(price: '10.55', product: 'misc product', quantity: 1) }

  describe '#total' do
  end

  describe '#new' do
    subject { described_class.new(checkout_item_misc) }

    it 'should have type set to standard tax rate' do
      expect(subject.type).to eq(:STANDARD_TAX_RATE)
    end

    it 'should have the rate set to standard tax rate decimal format' do
      expect(subject.rate).to eq(BigDecimal('0.1'))
    end
  end
end
