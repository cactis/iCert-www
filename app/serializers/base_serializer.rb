class BaseSerializer < ActiveModel::Serializer
  attributes :id, :updated_at, :created_at, :state, :status, :pri_button, :next_event
end
