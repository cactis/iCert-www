require 'action_view'
require 'action_view/helpers'

# require 'rmagick'
require 'rmagick'
include Magick


include ActionView::Helpers::DateHelper

class Cert < ApplicationRecord

  def self.generate_photos!
    all.each {|c| c.generate_photo! }
  end

  def photo
    # if photos.count > 0 
    #   photos.destroy_all 
    # end
    generate_photo! if photos.count == 0
    # { file_url: paper_url, thumb_url: paper_url }
    # , html_url: html_url }
    photos.first
  end

  def paper_url  
    "#{Settings.host}/api/certs/#{id}/paper"
  end

  def theme
    template = %w(CCB5.png GCB5.png GTA4.png).sample
    # template = %w(CCB5.png GCB5.png GTA4.png).first
    "#{Rails.root}/db/seeds/#{template}"
  end

  def generate_photo!
    photos.destroy_all
    # kit = IMGKit.new(html)
    # kit.to_file "#{Rails.root}/public/cert.jpg"
     img = ImageList.new(theme)
    # smallcat = cat.minify
    # smallcat.display    
    watermark = Image.new(600, 50) do |c|
      c.background_color= "Transparent"
    end

    watermark_text = Draw.new
    watermark_text.annotate(watermark, 0,0,0,0, title) do
      watermark_text.gravity = CenterGravity
      self.fill = 'Black'
      self.pointsize = 30
      self.font_family = "cwTeXKai"
      self.font_weight = BoldWeight
      self.stroke = "none"
    end
    img.composite!(watermark, CenterGravity, 0, -100,HardLightCompositeOp)               #Bottom-Right Marking

    img.write temp_file
    photos.create(remote_file_url: temp_file_url)
    log photos.first.file_url
  end

  def temp_file    
    "#{Rails.root}/public/uploads/cert.jpg"    
  end

  def temp_file_url 
    "#{Settings.host}/uploads/cert.jpg"    
  end

  typed_store :settings do |t|
    # s.string :qrcode_token
    # s.datetime :qrcode_token_at
  end

  def qrcode_token!
    if update_attributes!({qrcode_token_at: Time.now, qrcode_token: get_unique_token})
      log (open "#{Settings.host}/api#{request_code_url}")
      return qrcode_token
    end
  end

  def request_code_url
    "/certs/#{self.id}/papers/new?token=#{self.qrcode_token}"
  end


  def get_unique_token
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless self.class.exists?(qrcode_token: token)
    end
  end

  def info
    # "<html><head>"
    # "<meta name='viewport' content='width=device-width, initial-scale=1.0'>" \
    # "<style>body{padding: 1em}th{align:right; width: 30%}td{width: 50%} img{max-wdith: 100%; height: auto; margin: 1em; display: block}</style>" \
    # "</head>" \
    # "<body>" \
    "<table>" \
    "<tr><th>證書發行單位:</th><td>中國文化大學</td></tr>" \
    "<tr><th>ICERT 平台 SSL 憑證:</th><td>#{get_unique_token}</td></tr>" \
    "<tr><th>ICERT 區塊鏈編號:</th><td>#{get_unique_token}</td></tr>" \
    "</table>" \
    # "<img src='https://i.imgur.com/J35lG4U.jpg'/>" \
    # "</body></html>"
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

  after_create do |record|
    # photos.seed!
    generate_photo!
  end

  def status
    # log User.is_admin?, "User.is_admin?: #{User.count}"
    case aasm.current_state
    when :draft
      "課程進行中 #{course.percentage} %" if User.is_admin?
    when :unconfirmed
      "核發通過" if User.is_admin?
    when :confirmed
      "已核發"
    end
  end

  def expired_info
    if User.is_admin?
      expired_date ? "到期日: #{time_ago_in_words expired_date} 到期" : "永久有效"
    else
      expired_date ? "到期日: #{time_ago_in_words expired_date} 到期\n課程進行中 #{course.percentage} %" : "永久有效"
    end
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
