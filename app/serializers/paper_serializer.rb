class PaperSerializer < BaseSerializer
  attributes :receive_at
  has_one :cert
end
