class HealthRails::HealthController < ApplicationController
  # GET /health
  def index
    health_check = HealthRails::HealthCheck.new
    if health_check.all_ok?
      render text: "All OK"
    else
      render text: health_check.error_messages, status: :service_unavailable
    end
  end
end
