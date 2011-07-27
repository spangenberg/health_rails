require 'securerandom'

module HealthRails
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path("../../templates", __FILE__)

      desc "Creates a HealthRails initializer."

      def copy_initializer
        template "health_rails.rb", "config/initializers/health_rails.rb"
      end
    end
  end
end
