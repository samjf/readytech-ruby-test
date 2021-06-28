# frozen_string_literal: true

require 'bigdecimal'

module TaxRates
  STANDARD_TAX_RATE = 'STANDARD_TAX_RATE'

  RATES = {
    STANDARD_TAX_RATE: {
      rate: BigDecimal('0.1')
    }
  }.freeze

  def self.determine_tax_type(_product_name)
    :STANDARD_TAX_RATE
  end
end
