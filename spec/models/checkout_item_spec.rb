require 'app_helper'
require 'bigdecimal'

RSpec.describe CheckoutItem do
  subject { described_class.new price: '15.55', quantity: 1, product: 'Product'}

  describe "#price" do
    it "should return a BigDecimal for price" do
      expect(subject.price).to be_instance_of(BigDecimal)
    end
  end

  describe "self.build_items" do
    subject { described_class.build_items([[1, 'book', '12.49']])}

    it "should return a mapped object list of CheckoutItems" do
      expect(subject[0]).to have_attributes(price: BigDecimal('12.49'), quantity: 1, product: 'book')
    end
  end
  
end