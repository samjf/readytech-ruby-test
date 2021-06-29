# frozen_string_literal: true

require 'bigdecimal'

class CheckoutItem
  attr_accessor :price, :quantity, :product

  def initialize(price: BigDecimal('0.00'), quantity: 0, product: nil)
    @price = BigDecimal(price)
    @quantity = BigDecimal(quantity)
    @product = product
  end

  def self.build_items(checkout_list)
    checkout_list.map do |item|
      quantity, product, price = item
      new(quantity: quantity, product: product, price: price)
    end
  end
end
