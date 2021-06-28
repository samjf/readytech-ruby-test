require 'bigdecimal'

class CheckoutItem

  attr_accessor :price, :quantity, :product

  def initialize price: BigDecimal('0.00'), quantity: 0, product: nil
    @price = BigDecimal(price)
    @quantity = quantity
    @product = product
  end

  def self.build_items checkout_list
    checkout_list.map {|item|
      quantity, product, price = item
      self.new(quantity: quantity, product: product, price: price)
    }
  end
end