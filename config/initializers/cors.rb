# config/initializers/cors.rb
# ref: https://github.com/cyu/rack-cors

# font cors issue with CDN
# Ref: https://stackoverflow.com/questions/56960709/rails-font-cors-policy
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*'
    resource '/packs/*', headers: :any, methods: [:get, :options]
    resource '/audio/*', headers: :any, methods: [:get, :options]
    # Make the public endpoints accessible to the frontend
    resource '/public/api/*', headers: :any, methods: :any

    if ActiveModel::Type::Boolean.new.cast(ENV.fetch('CW_API_ONLY_SERVER', false)) || Rails.env.development?
      resource '*', headers: :any, methods: :any, expose: %w[access-token client uid expiry]
    end

    if ActiveModel::Type::Boolean.new.cast(ENV.fetch('ENABLE_API_CORS', false))
      resource '/api/*', headers: :any, methods: :any, expose: %w[access-token client uid expiry]
    end
  end

  # Widget cross-site cookie support
  # Allows the widget to work from any domain with credentials (cookies)
  allow do
    origins do |origin, _env|
      # Allow all origins for widget embedding
      # This is safe because authentication is handled via pubsub_token, not cookies
      true
    end
    resource '/public/*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options, :head],
             credentials: true
    resource '/api/v1/widget/*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options, :head],
             credentials: true
  end
end

################################################
######### Action Cable Related Config ##########
################################################

# Mount Action Cable outside main process or domain
# Rails.application.config.action_cable.mount_path = nil
# Rails.application.config.action_cable.url = 'wss://example.com/cable'
# Rails.application.config.action_cable.allowed_request_origins = [ 'http://example.com', /http:\/\/example.*/ ]

# To Enable connecting to the API channel public APIs
# ref : https://medium.com/@emikaijuin/connecting-to-action-cable-without-rails-d39a8aaa52d5
Rails.application.config.action_cable.disable_request_forgery_protection = true
