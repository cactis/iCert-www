class AssetSerializer < ActiveModel::Serializer
  attributes :id, :file_url, :thumb_url

  def thumb_url
    object.file.thumb.url
  end
end
