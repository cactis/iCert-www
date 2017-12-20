class PaperSerializer < BaseSerializer
  attributes :receive_at, :request_by_code, :paid_code_url
  has_one :cert
end
