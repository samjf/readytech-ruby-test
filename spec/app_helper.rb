# require all files with app for testing
Dir[File.expand_path('app/**/*.rb')].each { |f| require f }