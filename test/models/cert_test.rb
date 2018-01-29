# == Schema Information
#
# Table name: certs
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  course_id       :integer
#  title           :string(255)
#  expired_date    :datetime
#  aasm_state      :string(255)
#  qrcode_token    :string(255)
#  qrcode_token_at :datetime
#  settings        :text(65535)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_certs_on_course_id     (course_id)
#  index_certs_on_qrcode_token  (qrcode_token)
#  index_certs_on_user_id       (user_id)
#

require 'test_helper'

class CertTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
