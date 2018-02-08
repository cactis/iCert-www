class CertSerializer < BaseSerializer
	attributes :title, :user, :expired_date, :expired_info, :request_code_url, :info, :validate_url
	has_one :course
	has_one :photo
	has_many :photos

end

# == Schema Information
#
# Table name: certs
#
#  id                 :integer          not null, primary key
#  course_user_id     :integer          not null
#  course_template_id :integer          not null
#  title              :string(255)
#  expired_date       :datetime
#  aasm_state         :string(255)
#  qrcode_token       :string(255)
#  qrcode_token_at    :datetime
#  blockchain_token   :string(255)
#  settings           :text(65535)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_certs_on_course_template_id                     (course_template_id)
#  index_certs_on_course_template_id_and_course_user_id  (course_template_id,course_user_id) UNIQUE
#  index_certs_on_course_user_id                         (course_user_id)
#  index_certs_on_qrcode_token                           (qrcode_token)
#
