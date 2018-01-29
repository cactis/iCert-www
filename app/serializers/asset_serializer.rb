# == Schema Information
#
# Table name: assets
#
#  id             :integer          not null, primary key
#  user_id        :integer
#  type           :string(255)
#  assetable_type :string(255)
#  assetable_id   :integer
#  file           :string(255)
#  settings       :text(65535)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_assets_on_assetable_type_and_assetable_id  (assetable_type,assetable_id)
#  index_assets_on_type                             (type)
#  index_assets_on_user_id                          (user_id)
#

class AssetSerializer < ActiveModel::Serializer
  attributes :id, :file_url, :thumb_url

  def thumb_url
    object.file.thumb.url
  end
end
