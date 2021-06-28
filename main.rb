require 'csv'

def main
  Dir[File.expand_path('input/*.csv')].each { |input_file|
    csv_file_to_2d_array(input_file) 
  }
end

def csv_file_to_2d_array file
  CSV.read(file, { headers: true })
end

