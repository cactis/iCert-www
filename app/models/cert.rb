require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper

class Cert < ApplicationRecord

  typed_store :settings do |s|
    # s.string :qrcode_token
    # s.datetime :qrcode_token_at
  end

  def qrcode_token!
    if update_attributes!({qrcode_token_at: Time.now, qrcode_token: get_unique_token})
      # log (open "http://icert.airfont.com/api/certs/4/papers/new?token=#{self.qrcode_token}")
      qrcode_token
    end
  end

  def get_unique_token
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless self.class.exists?(qrcode_token: token)
    end
  end


  belongs_to :user
  belongs_to :course
  has_many :papers, dependent: :destroy
  has_many :udollars, foreign_key: "payable_id", foreign_type: "payable_type", dependent: :destroy

  has_many :assets, as: :assetable, dependent: :destroy
  has_many :photos, as: :assetable
  accepts_nested_attributes_for :photos
  # has_one :photo, as: :assetable, dependent: :destroy

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
    super
    case state
    when :unconfirmed
      User.first.push!({title: "課程已結束囉", body: "本結業證書由證書組核發中。"}, {state: state})
    when :confirmed
      # !!!!! 加入發 UD 的程序
      Udollar.after_cert_created!(self)
    end
  end

  def photo
    photos.first
  end

  # def after_print
  #   payment = -2
  #   Udollar.create payment: payment, balance: Udollar.balance + payment, title: "申請輸出 #{record.title} 正本", message: "申請正本輸出，扣 #{payment} 元"
  # end

  after_create do |record|
    # payment = 2
    # Udollar.create payable: record, payment: payment, balance: Udollar.balance + payment, title: "獲得 #{record.title}", message: "每獲得一張結業證書，就獲得 #{payment} 元 UDollar。可用於後續紙本印刷"
    photos.seed!
  end

  def status
    case aasm.current_state
    when :draft
      "課程進行中 #{course.percentage} %"
    when :unconfirmed
      "核發通過"
    when :confirmed
      "已核發"
    end
  end

  def expired_info
    expired_date ? "#{time_ago_in_words expired_date} 到期" : "永久有效"
  end

  def self.seed!(index = 0)
    cert = super
    cert.photos.seed!
  end

  def self.seed_params(index = 0)
    {
      user: User.first,
      title: Faker::Coffee.blend_name,
      expired_date: [Time.now + 3.year, nil].sample, #[(Time.now + 3.year).to_date, nil].sample
    }
  end

  before_create do |record|
    record.title = course ? course.title : record.title
  end

  def title
    "#{self[:title]} 結業證書"
  end

end
