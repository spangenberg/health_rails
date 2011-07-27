require 'active_record'

check "ActiveRecord connection", false do
  active_record_connection = ActiveRecord::Base.connection
  unless active_record_connection.active?
    raise HealthCheckFailure, "#{active_record_connection.adapter_name} connection is gone from us!"
  end
end
