# frozen_string_literal: true

require 'bigdecimal'

module TaxRates
  STANDARD_TAX_RATE = 'STANDARD_TAX_RATE'

  EXEMPT_PRODUCT = %w[book chocolate pills].freeze

  RATES = {
    STANDARD_TAX_RATE: {
      rate: BigDecimal('0.1')
    },
    EXEMPT: {
      rate: BigDecimal('0')
    }
  }.freeze

  def self.determine_tax_type(product_name)
    if EXEMPT_PRODUCT.any? { |ex_product| product_name.include?(ex_product) }
      :EXEMPT
    else
      :STANDARD_TAX_RATE
    end
  end
end
