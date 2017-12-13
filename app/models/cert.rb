require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper

class Cert < ApplicationRecord

  belongs_to :user
  belongs_to :course

  include AASM

  aasm :logger => Rails.logger do

    state :draft, initial: true
    state :unconfirmed, after_enter: :after_state
    state :confirmed, after_enter: :after_state
    # state :gettable, :printed

    event :ready_to_confirm do; transitions from: [:draft, :unconfirmed, :confirmed], to: :unconfirmed; end
    event :confirm do; transitions from: [:unconfirmed, :confirmed], to: :confirmed; end
    # event :print, after_event: :after_print do; transitions from: :gettable, to: :printed; end
  end

  def after_state
    log aasm.current_state, 'aasm.current_state'
    case aasm.current_state
    when :unconfirmed
      User.first.push!({title: "課程已結束囉", body: "本結業證書由證書組核發中。"}, {state: "unconfirmed"})
    when :confirmed
      # !!!!! 加入發 UD 的程序
      User.first.push!({title: "證書發下來囉", body: "本結業證書已由證書組核發到您的帳戶。並提供 2 元 Udallor 基金以便申請列印之用。"}, {state: "confirmed"})
    end
  end

  def after_print
    payment = -2
    Udollar.create payment: payment, balance: Udollar.balance + payment, title: "申請輸出 #{record.title} 正本", message: "申請正本輸出，扣 #{payment} 元"
  end

  after_create do |record|
    payment = 2
    Udollar.create payment: payment, balance: Udollar.balance + payment, title: "獲得 #{record.title}", message: "每獲得一張結業證書，就獲得 #{payment} 元 UDollar。可用於後續紙本印刷"
  end

  def status
    case aasm.current_state
    when :draft
      "尚未結業"
    when :unconfirmed
      "審核中"
    when :confirmed
      "已核發"
    end
  end

  def expired_info
    expired_date ? "#{time_ago_in_words expired_date} 到期" : "永久有效"
  end

  def self.seed_params(index = 0)
    {
      user: User.first,
      title: Faker::Coffee.blend_name,
      expired_date: [Time.now + 3.year, nil].sample #[(Time.now + 3.year).to_date, nil].sample
    }
  end

  before_create do |record|
    record.title = course ? course.title : record.title
  end

  def title
    "#{self[:title]} 結業證書"
  end

end
