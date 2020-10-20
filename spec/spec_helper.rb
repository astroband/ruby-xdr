# frozen_string_literal: true

require "simplecov"
SimpleCov.start do
  enable_coverage :branch
end

require "xdr"

Dir["#{__dir__}/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  
end
