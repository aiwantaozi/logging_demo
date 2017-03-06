require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

require 'require_all'

# for datamapper
require 'rubygems'
require 'data_mapper' 

require_rel '../lib/**/*.rb'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ApiDemo
  class Application < Rails::Application
    config.autoload_paths << Rails.root.join('lib')

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    
    # config.middleware.insert_before(Rails::Rack::Logger, ServerUser::URLLogger)
    # config.middleware.delete(Rails::Rack::Logger)
    
	config.action_dispatch.default_headers = {
	    'Access-Control-Allow-Origin' => '*',
	    'Access-Control-Request-Method' => %w{GET POST}.join(",")
	  }
    config.api_only = true

    config.lograge.enabled = true
    # custom_options can be a lambda or hash
    # if it's a lambda then it must return a hash
    INTERNAL_PARAMS = ActionController::LogSubscriber::INTERNAL_PARAMS
    config.lograge.custom_options = lambda do |event|
      # capture some specific timing values you are interested in
      { _key: "user_service", timing: event.time, path: event.payload[:path], agent: event.payload[:agent], :host => event.payload[:host], params: event.payload[:params].except(*INTERNAL_PARAMS) }
    end
    config.lograge.formatter = Lograge::Formatters::Json.new

  end
  DataMapper::Logger.new($stdout, :debug)
  # A MySQL connection:
  DataMapper.setup(:default, 'mysql://demo:demo@db/demo')
end
