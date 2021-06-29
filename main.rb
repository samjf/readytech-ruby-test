# frozen_string_literal: true

require 'csv'
require_relative 'app/models/checkout_item'
require_relative 'app/models/receipt'

###
# Read each input csv file from `$root/input/*.csv`
# and print to stdout for each input.
###
def main
  process_csv_files_from_dir
end

def process_csv_files_from_dir
  Dir[File.expand_path('input/*.csv')].each do |input_file|
    item_list = csv_file_to_2d_array(input_file)
    checkout_items = CheckoutItem.build_items(item_list)
    receipt = Receipt.new(checkout_items)
    print_receipt(input_file, receipt)
  end
end

def print_receipt(input_file, receipt)
  puts <<~OUTPUT
    Output for #{input_file}\n
    ------------------------\n
    #{receipt}
    ------------------------\n\n
  OUTPUT
end

def csv_file_to_2d_array(file)
  rows = CSV.read(file)
  rows[1..]
end

main
