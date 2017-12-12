require "awesome_print"
class ApplicationController < ActionController::API
  before_action :log_request
  before_action :log_params

  def authorization_token
  end

  protected
  def log_request
    logger.info("URL: #{request.method} --- #{request.url} --- #{authorization_token}")
  end

  def log_params
    log params.permit!, 'params'
  end

  def log(msg, title = 'debug info')
    Rails.logger.ap ">>> #{title.to_s} "
    if msg.is_a? Hash
      [:controller, :action, :file_name, :func_name, :app_id, :token].each { |key| msg.delete key }
    end
    Rails.logger.ap msg.respond_to?(:to_h) ? msg.to_h : msg
    Rails.logger.ap "<<< #{title.to_s} [#{controller_name}]#[#{action_name}] #{authorization_token}"
  end



end
