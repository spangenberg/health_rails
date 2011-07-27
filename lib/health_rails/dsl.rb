module HealthRails
  module DSL
    class HealthCheckFailure < Exception
    end

    def check(description, auto_activated=true, &health_check_block)
      HealthRails::HealthCheck.check(description, auto_activated, &health_check_block)
    end
  end
end

include HealthRails::DSL
