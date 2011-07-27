# Use this hook to configure health rails.
HealthRails.setup do |config|
  # Configure which health checks should be processed.
  config.health_checks = [ 'ActiveRecord connection' ]

  # Custom checks
  #
  # check "Fail" do
  #   raise HealthCheckFailure, "It failed!"
  # end
  #
  # check "Pass" do
  #   if false
  #     raise HealthCheckFailure, "It failed, OMG!"
  #   end
  # end
end
