# == Schema Information
#
# Table name: papers
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  cert_id         :integer
#  pay_at          :datetime
#  printout_at     :datetime
#  deliver_at      :datetime
#  receive_at      :datetime
#  rate_at         :datetime
#  paid_code       :string(255)
#  paid_code_at    :datetime
#  request_by_code :boolean
#  aasm_state      :string(255)
#  settings        :text(65535)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
# Indexes
#
#  index_papers_on_cert_id    (cert_id)
#  index_papers_on_paid_code  (paid_code)
#  index_papers_on_user_id    (user_id)
#

class PaperSerializer < BaseSerializer
  attributes :receive_at, :request_by_code, :paid_code_url
  has_one :cert
end
