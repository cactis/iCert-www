# == Schema Information
#
# Table name: udollars
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  payable_type :string(255)
#  payable_id   :integer
#  payment      :integer
#  balance      :integer          default(0)
#  title        :string(255)
#  message      :string(255)
#  aasm_state   :string(255)
#  settings     :text(65535)
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_udollars_on_payable_type_and_payable_id  (payable_type,payable_id)
#  index_udollars_on_user_id                      (user_id)
#

class UdollarSerializer < BaseSerializer
  attributes :payment, :title, :message, :balance, :payable_type, :payable_id
end
