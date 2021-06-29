# frozen_string_literal: true

require 'app_helper'
RSpec.describe Receipt do
  subject { described_class.new(checkout_items_set_one) }
  let(:checkout_items_set_one) do
    [
      CheckoutItem.new(price: '12.49', quantity: 1, product: 'book'),
      CheckoutItem.new(price: '14.99', quantity: 1, product: 'music CD'),
      CheckoutItem.new(price: '0.85', quantity: 1, product: 'chocolate bar'),
    ]
  end

  describe '#to_csv' do
  end

  describe '#total_sales_tax' do
    it 'should correctly sum the sales tax for the receipt line items' do
      expect(subject.total_sales_tax).to eq(BigDecimal('1.5'))
    end
  end

  describe '#total' do
    it 'should correctly sum the line items totals incl. tax' do
      expect(subject.total).to eq(BigDecimal('29.83'))
    end
  end

  describe '#to_s' do
    it 'should correctly match expected display output' do
      expect(described_class.new(checkout_items_set_one).to_s).to eq <<~EXPECTED_OUTPUT.strip
        1, book, 12.49
        1, music CD, 16.49
        1, chocolate bar, 0.85

        Sales Taxes: 1.50
        Total: 29.83
      EXPECTED_OUTPUT
    end
  end
end
