# -*- encoding : utf-8 -*-
module ApplicationHelper

  def include_controller_stylesheet
    stylesheet_link_tag controller_name if File.exists?("#{Rails.root}/app/assets/stylesheets/#{controller_name}.css.less")
  end

  def include_controller_action_stylesheet
    stylesheet_link_tag "#{controller_name}_#{action_name}" if File.exists?("#{Rails.root}/app/assets/stylesheets/#{controller_name}_#{action_name}.css.less")
  end

  def include_controller_javascript
    javascript_include_tag controller_name if File.exists?("#{Rails.root}/app/assets/javascripts/#{controller_name}.js.coffee")
  end

  def include_controller_action_javascript
    javascript_include_tag "#{controller_name}_#{action_name}" if File.exists?("#{Rails.root}/app/assets/javascripts/#{controller_name}_#{action_name}.js.coffee")
  end

end
