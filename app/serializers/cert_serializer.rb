class CertSerializer < BaseSerializer
  attributes :title, :user, :expired_date, :expired_info
  has_one :photo
  has_many :photos
end
