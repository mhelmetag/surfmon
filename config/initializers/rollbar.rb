# frozen_string_literal: true

Rollbar.configure do |config|
  config.access_token = ENV['ROLLBAR_ACCESS_TOKEN']

  # Here we'll disable in 'test' and 'development':
  config.enabled = false if Rails.env.test? || Rails.env.development?

  config.environment = ENV['ROLLBAR_ENV'].presence || Rails.env

  config.exception_level_filters.merge!(
    {
      'ActionController::RoutingError' => 'ignore'
    }
  )
end
