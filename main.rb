# frozen_string_literal: true

require 'csv'
require File.expand_path('app/models/checkout_item')

def main
  Dir[File.expand_path('input/*.csv')].each do |input_file|
    item_list = csv_file_to_2d_array(input_file)
    checkout_items = CheckoutItem.build_items(item_list)
  end
end

def csv_file_to_2d_array(file)
  rows = CSV.read(file)
  rows[1..]
end

main
