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

  def total_excl_tax
    @quantity * @price
  end

  def sales_tax
    (total_excl_tax * @rate).round(2)
  end

  def total_incl_tax
    total_excl_tax + sales_tax
  end
end
