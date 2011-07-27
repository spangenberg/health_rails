$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'health_rails'

RSpec.configure do |config|
  config.mock_with :rspec
end
