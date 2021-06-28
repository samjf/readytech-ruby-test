# frozen_string_literal: true

require_relative '../helpers/tax_rates'

class LineItem
  attr_accessor :quantity, :product, :price, :type, :rate

  def initialize(checkout_item)
    @quantity = checkout_item.quantity
    @product = checkout_item.product
    @price = checkout_item.price
    @type = TaxRates.determine_tax_type(@product)
    @rate = TaxRates::RATES[@type][:rate]
  end
end
