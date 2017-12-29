# encoding: utf-8
require "awesome_print"
class ApplicationController < ActionController::API
  before_action :configure_charsets
  before_action :log_request
  before_action :log_params

  def all_aasm_state
    json = {}
    resource_class.aasm.states.each do |state|
      json[state.name] = eval("#{resource_class.name}.#{state}").map{|item| eval("#{resource_class}Serializer.new(item)")}
    end
    json
  end


  def authorization_token
  end

  def routes; request.fullpath.split('/'); end
  def parent_class
    if routes[routes.rindex(controller_name) - 2].present?
      routes[routes.rindex(controller_name) - 2].classify.constantize
    end
  end
  def parent_id; routes[routes.rindex(controller_name) - 1].to_i; end
  def parent; parent_class ? parent_class.find(parent_id) : nil; end
  def resource_class; controller_name.classify.constantize; end
  def resource; resource_class.find(params[:id]); end


  def alert(message)
    headers["alert"] = message #{}"abc已完成中文abc 222" #message
    # resource.alert = message
  end

  def render_error_message(e, status = 400)
    render json: { alert: e.message.gsub(": ", ":\n").gsub(", ", "\n")}, status: status
  end

  protected
  def configure_charsets
    headers["Content-Type"] = "text/html; charset=UTF-8"
  end

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
