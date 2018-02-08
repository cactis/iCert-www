class TemplateSerializer < ActiveModel::Serializer
  attributes :id, :title, :data, :edit_url
  def edit_url
    "#{Settings.host}/api/templates/#{object.id}/edit"
  end
end

# == Schema Information
#
# Table name: templates
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)
#  data       :text(65535)
#  settings   :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_templates_on_user_id  (user_id)
#
