class BaseSerializer < ActiveModel::Serializer
  attributes :id, :updated_at, :created_at, :state, :status
end
