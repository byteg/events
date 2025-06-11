require "simplecov"
require_relative 'support/coverage'

SimpleCov.start do
  add_filter "/spec/"
end

Dir[File.expand_path("../../app/**/*.rb", __FILE__)].sort.each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end