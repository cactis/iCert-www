class Asset < ApplicationRecord
  belongs_to :assetable, polymorphic: true
  mount_uploader :file, AssetUploader
  default_scope { order "id desc" }

  # validates :file, presence: true
end
