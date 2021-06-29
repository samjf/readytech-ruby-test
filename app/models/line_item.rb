# frozen_string_literal: true

require_relative '../helpers/tax_rates'

###
# A single line item for a Receipt.
#  - accepts a `CheckoutItem` as input
###
class LineItem
  attr_accessor :quantity, :product, :price, :type, :rate, :imported

  def initialize(checkout_item)
    @quantity = checkout_item.quantity
    @product = checkout_item.product
    @price = checkout_item.price
    @type = TaxRates.determine_tax_type(@product)
    @imported = TaxRates.imported?(@product)
    @rate = TaxRates.calculate_rate(@type, imported: @imported)
  end

  def total_excl_tax
    @quantity * @price
  end

  def sales_tax
    tax = (total_excl_tax * @rate)
    if tax.zero?
      tax
    else
      fractional_component = tax.frac
      # add on the difference of modulo. e.g. 1.82 will add on 0.03
      mod = fractional_component % BigDecimal('0.05')
      tax += (mod.zero? ? 0 : BigDecimal('0.05') - mod)
      tax.round(2)
    end
  end

  def total_incl_tax
    total_excl_tax + sales_tax
  end

  def imported?
    @imported
  end
end
