module HealthRails
  class HealthCheck
    def all_ok?
      process_checks
      !errors.any?
    end

    def check(description)
      checks[description]
    end

    def checks
      HealthCheck.checks
    end

    def error_messages
      errors.join("\n")
    end

    def errors
      @errors ||= []
    end

    def process_check(description)
      begin
        check(description).call
      rescue HealthCheckFailure => error_message
        errors << "#{description}: #{error_message}"
      end
    end

    def process_checks
      checks.each do |description, proc|
        next unless HealthRails.health_checks.include?(description)
        process_check(description)
      end
    end

    class << self

      def check(description, auto_activated, &block)
        if auto_activated && !HealthRails.health_checks.include?(description)
          HealthRails.health_checks << description
        end
        checks[description] = block
      end

      def checks
        @@checks ||= {}
      end
    end
  end
end

# Load all health checks
Dir["#{File.dirname(__FILE__)}/health_checks/**/*.rb"].each { |f| require f }
