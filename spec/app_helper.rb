# frozen_string_literal: true

# require all files with app for testing
Dir[File.expand_path('app/**/*.rb')].sort.each { |f| require f }
