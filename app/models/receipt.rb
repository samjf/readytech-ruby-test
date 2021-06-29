# frozen_string_literal: true

require_relative './line_item'

###
# A receipt which sums and lists the checkout transactions
# - accepts an array of `CheckoutItem`
###
class Receipt
  def initialize(checkout_items = [])
    @line_items = Receipt.map_checkout_items_to_line_items(checkout_items)
  end

  def self.map_checkout_items_to_line_items(checkout_items)
    checkout_items.map do |co_item|
      LineItem.new(co_item)
    end
  end

  def total_sales_tax
    @line_items.sum(&:sales_tax)
  end

  def total
    @line_items.sum(&:total_incl_tax)
  end

  def to_s
    receipt_lines = @line_items.map do |line_item|
      "#{line_item.quantity.to_i}, #{line_item.product}, #{format_currency(line_item.total_incl_tax)}"
    end
    receipt_lines << "\nSales Taxes: #{format_currency(total_sales_tax)}"
    receipt_lines << "Total: #{format_currency(total)}"
    receipt_lines.join("\n")
  end

  private

  ###
  # accepts a big decimal and converts to a string
  ###
  def format_currency(amount)
    format('%.2f', amount)
  end
end
