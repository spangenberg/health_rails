require 'health_rails/rails'

module HealthRails
  autoload :HealthCheck, 'health_rails/health_check'
  # Health checks which will be processed.
  mattr_accessor :health_checks
  @@health_checks = []

  # Default way to setup HealthRails. Run rails generate health_rails:install to create
  # a fresh initializer with all configuration values.
  def self.setup
    yield self
  end
end
