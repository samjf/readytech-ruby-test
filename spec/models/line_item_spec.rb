# frozen_string_literal: true

require 'app_helper'
require 'bigdecimal'
RSpec.describe LineItem do
  let(:checkout_item_misc) { CheckoutItem.new(price: '14.99', product: 'misc product', quantity: 1) }
  let(:checkout_item_exempt) { CheckoutItem.new(price: '12.55', product: 'chocolate milk', quantity: 1) }
  let(:checkout_item_imported) { CheckoutItem.new(price: '12.55', product: 'imported chocolate', quantity: 1) }
  let(:checkout_item_standard_imported) { CheckoutItem.new(price: '12.55', product: 'imported perfume', quantity: 1) }
  subject { described_class.new(checkout_item_misc) }

  describe '#total_excl_tax' do
    it 'should total the line item price considering the quantity' do
      subject.quantity = 2
      expect(subject.total_excl_tax).to eq(BigDecimal('29.98'))
    end
  end

  describe '#total_incl_tax' do
    it 'should total the line item price considering the quantity' do
      expect(subject.total_incl_tax).to eq(BigDecimal('16.49'))
    end
  end

  describe '#sales_tax' do
    it 'should calculate the tax on the total item price' do
      expect(subject.sales_tax).to eq(BigDecimal('1.50'))
    end
  end

  describe '#new' do
    subject { described_class.new(checkout_item_misc) }

    it 'should have type set to standard tax rate' do
      expect(subject.type).to eq(:STANDARD_TAX_RATE)
    end

    it 'should have the rate set to standard tax rate decimal format' do
      expect(subject.rate).to eq(BigDecimal('0.1'))
    end

    context 'given a exempt product' do
      subject { described_class.new(checkout_item_exempt) }

      it 'should have type set to exempt tax rate' do
        expect(subject.type).to eq(:EXEMPT)
      end

      it 'should have the rate set to exempt rate decimal format' do
        expect(subject.rate).to eq(BigDecimal('0'))
      end
    end

    context 'given a imported product' do
      subject { described_class.new(checkout_item_imported) }

      it 'should have imported flag set' do
        expect(subject.imported?).to be_truthy
      end

      it 'should have the rate set to imported rate decimal format' do
        expect(subject.rate).to eq(BigDecimal('0.05'))
      end
    end

    context 'given a standard rate imported product' do
      subject { described_class.new(checkout_item_standard_imported) }

      it 'should have imported flag set' do
        expect(subject.imported?).to be_truthy
      end

      it 'should have the rate set to imported rate decimal format' do
        expect(subject.rate).to eq(BigDecimal('0.15'))
      end
    end
  end
end
