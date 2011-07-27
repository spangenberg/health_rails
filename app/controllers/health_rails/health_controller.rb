class HealthRails::HealthController < ApplicationController
  before_filter :login_required

  # GET /health
  def index
    health_check = HealthRails::HealthCheck.new
    if health_check.all_ok?
      render text: "All OK"
    else
      render text: health_check.error_messages, status: :service_unavailable
    end
  end

  private
    def login_required
      if HealthRails.authentication
        authenticate_or_request_with_http_basic("#{Rails.application.class.parent_name}'s health is important to us!") do |username, password|
          HealthRails.authentication.has_key?(username) && HealthRails.authentication[username] == password
        end
      end
    end
end
