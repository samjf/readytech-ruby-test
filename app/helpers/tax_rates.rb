# frozen_string_literal: true

require 'bigdecimal'

module TaxRates
  STANDARD_TAX_RATE = 'STANDARD_TAX_RATE'

  EXEMPT_PRODUCT = %w[book chocolate pills].freeze

  IMPORTED_PRODUCT = %w[imported].freeze

  RATES = {
    STANDARD_TAX_RATE: {
      rate: BigDecimal('0.1')
    },
    EXEMPT: {
      rate: BigDecimal('0')
    },
    IMPORTED: {
      rate: BigDecimal('0.05')
    }
  }.freeze

  def self.determine_tax_type(product_name)
    if EXEMPT_PRODUCT.any? { |ex_product| product_name.include?(ex_product) }
      :EXEMPT
    elsif IMPORTED_PRODUCT.any? { |imp_product| product_name.include?(imp_product) }
      :IMPORTED
    else
      :STANDARD_TAX_RATE
    end
  end
end
