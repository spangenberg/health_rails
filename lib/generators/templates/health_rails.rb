# Use this hook to configure health rails.
HealthRails.setup do |config|
  # Configure which health checks should be processed.
  config.health_checks = [ 'ActiveRecord connection' ]
end
