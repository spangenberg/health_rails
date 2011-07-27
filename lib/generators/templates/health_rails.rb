# Use this hook to configure health rails.
HealthRails.setup do |config|
  # Configure who can access your health check url.
  # You can configure as much users as you want,
  # or pass another backend for authentification.
  # If you don't want to have authentification,
  # remove the next line. This is not recommended!
  config.authentication = { "admin" => <%= SecureRandom.hex(16).inspect %> }

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
