require 'health_rails/dsl'
require 'health_rails/health_check'
require 'health_rails/rails'

module HealthRails
  # Users which have access to the health check url.
  mattr_accessor :authentication
  @@authentication = false

  # Health checks which will be processed.
  mattr_accessor :health_checks
  @@health_checks = []

  # Default way to setup HealthRails. Run rails generate health_rails:install to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end
end
