# frozen_string_literal: true

require 'bigdecimal'

module TaxRates
  STANDARD_TAX_RATE = :STANDARD_TAX_RATE
  EXEMPT_TAX_RATE = :EXEMPT
  IMPORT_TAX_RATE = :IMPORTED

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
      EXEMPT_TAX_RATE
    else
      STANDARD_TAX_RATE
    end
  end

  def self.calculate_rate(type, imported: false)
    total_rate = RATES[type][:rate]
    total_rate += RATES[IMPORT_TAX_RATE][:rate] if imported
    total_rate
  end

  def self.imported?(product_name)
    IMPORTED_PRODUCT.any? { |imp_product| product_name.include?(imp_product) }
  end
end
