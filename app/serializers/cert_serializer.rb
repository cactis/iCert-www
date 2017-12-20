class CertSerializer < BaseSerializer
  attributes :title, :user, :expired_date, :expired_info, :request_code_url
  has_one :course
  has_one :photo
  has_many :photos
end
