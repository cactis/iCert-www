class Udollar < ApplicationRecord

  # belongs_to :payable, polymorphic: true
  # belongs_to :cert, foreign_key: "payable_id", foreign_type: "payable_type"
  # belongs_to :paper, foreign_key: "payable_id", foreign_type: "payable_type"

  default_scope { order("id desc") }

  def self.balance
    first ? first.balance : 0
  end

  def self.after_cert_created!(cert)
    payment = 2
    title = "獲得 #{cert.title}"
    message = "本結業證書已由證書組核發到您的帳戶。每獲得一張證書，將提供 2 元 Udallor 基金以便申請列印之用。"
    run! cert, payment, title, message
  end

  def self.after_paper_created!(paper)
    payment = -2
    title =  "申請輸出 #{paper.title} 正本"
    message = "申請正本輸出，扣 Udollar #{ payment.abs } 元"
    run! paper, payment, title, message
  end

  def self.run!(payable, payment, title, message)
    if balance + payment < 0
      raise BalanceNotEnough
    else
      create! payable_type: payable.class.name, payable_id: payable.id, payment: payment, balance: balance + payment, title: title, message: message
      User.first.push!({title: title, body: message}, {state: "udollar"})
    end
  end

  class BalanceNotEnough < StandardError
    def message;  "Udollar 餘額為 #{Udollar.balance}，不足以支付本次操作。請立即儲值。"; end
    def status; 440; end
  end


end

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
