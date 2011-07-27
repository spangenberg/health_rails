Rails.application.routes.draw do
  match "/health" => "health_rails/health#index"
end
