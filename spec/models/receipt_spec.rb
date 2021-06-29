# frozen_string_literal: true

require 'app_helper'
RSpec.describe Receipt do
  subject { described_class.new(checkout_items_set_one) }
  let(:checkout_items_set_one) do
    [
      CheckoutItem.new(price: '12.49', quantity: 1, product: 'book'),
      CheckoutItem.new(price: '14.99', quantity: 1, product: 'music CD'),
      CheckoutItem.new(price: '0.85', quantity: 1, product: 'chocolate bar')
    ]
  end

  let(:checkout_items_set_two) do
    [
      CheckoutItem.new(price: '10.00', quantity: 1, product: 'imported box of chocolates'),
      CheckoutItem.new(price: '47.50', quantity: 1, product: 'imported bottle of perfume')
    ]
  end

  let(:checkout_items_set_three) do
    [
      CheckoutItem.new(quantity: 1, product: 'imported bottle of perfume', price: '27.99'),
      CheckoutItem.new(quantity: 1, product: 'bottle of perfume', price: '18.99'),
      CheckoutItem.new(quantity: 1, product: 'packet of headache pills', price: '9.75'),
      CheckoutItem.new(quantity: 1, product: 'imported box of chocolates', price: '11.25')
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
      expect(subject.to_s).to eq <<~EXPECTED_OUTPUT.strip
        1, book, 12.49
        1, music CD, 16.49
        1, chocolate bar, 0.85

        Sales Taxes: 1.50
        Total: 29.83
      EXPECTED_OUTPUT
    end

    context 'with set two of testing data' do
      subject { described_class.new(checkout_items_set_two) }

      it 'should correctly match expected display output' do
        expect(subject.to_s).to eq <<~EXPECTED_OUTPUT.strip
          1, imported box of chocolates, 10.50
          1, imported bottle of perfume, 54.65

          Sales Taxes: 7.65
          Total: 65.15
        EXPECTED_OUTPUT
      end
    end

    context 'with set three of testing data' do
      subject { described_class.new(checkout_items_set_three) }

      it 'should correctly match expected display output' do
        expect(subject.to_s).to eq <<~EXPECTED_OUTPUT.strip
          1, imported bottle of perfume, 32.19
          1, bottle of perfume, 20.89
          1, packet of headache pills, 9.75
          1, imported box of chocolates, 11.85

          Sales Taxes: 6.70
          Total: 74.68
        EXPECTED_OUTPUT
      end
    end
  end
end
