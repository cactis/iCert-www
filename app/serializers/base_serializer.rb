class BaseSerializer < ActiveModel::Serializer
  attributes :id, :updated_at, :created_at, :state, :status, :pri_button, :sub_button, :next_event

  include Rails.application.routes.url_helpers

  Rails.application.routes.default_url_options = {
    host: Settings.host
  }

  def log(*args)
    ActiveRecord::Base.log(args)
  end

end
