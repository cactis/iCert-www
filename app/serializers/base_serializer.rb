class BaseSerializer < ActiveModel::Serializer
	cache
	include Rails.application.routes.url_helpers
    attributes :id, :updated_at, :created_at, :state, :status, :pri_button, :sub_button, :next_event

  # attributes "#{object.class.attribute_names}"
  # attributes :url

  Rails.application.routes.default_url_options = {
  	host: 'icert.dev'
  }

  # def attributes(*args)
  # 	object.attributes.symbolize_keys
  # end

  def has_many(name, scope = nil, options = {}, &extension)
  	object.class.all_has_many
  end

  # def all_attributes; object.class.attribute_names; end

  def url
  	polymorphic_url object
  end
  
  def log(*args)
  	ActiveRecord::Base.log(args)
  end


end

# class BaseSerializer < ActiveModel::Serializer
# 	attributes :id, :updated_at, :created_at, :state, :status, :pri_button, :sub_button, :next_event

# 	include Rails.application.routes.url_helpers

# 	Rails.application.routes.default_url_options = {
# 		host: Settings.host
# 	}

# 	def attributes(*args)
# 		object.attributes.symbolize_keys
# 	end


# 	def log(*args)
# 		ActiveRecord::Base.log(args)
# 	end

# end
