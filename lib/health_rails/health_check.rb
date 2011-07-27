module HealthRails
  class HealthCheck
    class HealthCheckFailure < Exception
    end

    def all_ok?
      process_checks
      !errors.any?
    end

    def error_messages
      errors.join("\n")
    end

    def errors
      @errors ||= []
    end

    def process_check(description)
      begin
        HealthCheck.check(description).call
      rescue HealthCheckFailure => error_message
        errors << "#{description}: #{error_message}"
      end
    end

    def process_checks
      HealthCheck.checks.each do |description, proc|
        process_check(description)
      end
    end

    class << self

      def check(description, &block)
        if block.nil?
          checks[description]
        else
          checks[description] = block
        end
      end

      def checks
        @@checks ||= {}
      end
    end
  end
end

# Load all health checks
Dir["#{File.dirname(__FILE__)}/health_checks/**/*.rb"].each { |f| require f }
