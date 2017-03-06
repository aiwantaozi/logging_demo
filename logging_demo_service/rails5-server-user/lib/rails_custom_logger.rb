require "action_controller/log_subscriber"
require "byebug"

module ServerUser
  
  class << self
    attr_accessor :_user_id
    attr_accessor :_event
    attr_accessor :_request
  end
  
  class URLLogger < Rails::Rack::Logger
    INTERNAL_PARAMS = ActionController::LogSubscriber::INTERNAL_PARAMS

    def call_app(request, env)
      byebug
      request = ActionDispatch::Request.new(env)

      status, headers, body = @app.call(env)

      response = ActionDispatch::Response.new(status, headers, body)

      # payload   = ServerUser._event.payload
      # params  = payload[:params].except(*INTERNAL_PARAMS)
      # user_id = ServerUser._user_id.blank? ? "-" : ServerUser._user_id

      begin
        err_code = JSON.parse(response.body.to_s)['meta']['code']
      rescue
        err_code = -1
      end

      # message = "INFO\trails\t#{Time.now.to_default_s}\t#{ShineVersion::NUMBER}" +
      #   "\t#{request.user_agent}\t#{I18n.locale}\t-\t-\t#{request.ip}\t#{user_id}" +
      #   "\t#{payload[:method]}\t#{payload[:path]}\t#{payload[:controller]}##{payload[:action]}" +
      #   "\t#{payload[:status]}\t#{err_code}\t#{ServerUser._event.duration.round}\t-\t-\t#{params.inspect}"
      # info(message)

      [status, headers, body]
    ensure
      ActiveSupport::LogSubscriber.flush_all!
    end
  end
    
  class ActionController::LogSubscriber < ActiveSupport::LogSubscriber
    
    def start_processing(event)
      # log nothing!
    end
  
    def process_action(event)
      ServerUser._event = event
    end
  
    def logger
      ActionController::Base.logger
    end
  end
end