class Paper < ApplicationRecord

  belongs_to :cert
  has_many :udollars, foreign_key: "payable_id", foreign_type: "payable_type", dependent: :destroy

  typed_store :settings do |t|

  end

  include AASM
  aasm :logger => Rails.logger do
    # after_all_transitions :after_state
    state :unpaid, initial: true, after_enter: :after_state
    state :printable, after_enter: :after_state
    state :deliverable, after_enter: :after_state
    state :receivable, after_enter: :after_state
    state :rateable, after_enter: :after_state
    state :closed, after_enter: :after_state

    after_all_events :after_all_events
    event :pay, before_transaction: :pay_dollar! do; transitions from: :unpaid, to: :printable; end
    event :printout do; transitions from: :printable, to: :deliverable; end
    event :deliver do; transitions from: :deliverable, to: :receivable; end
    event :receive do; transitions from: [:receivable, :unpaid], to: :rateable; end
    event :rate do; transitions from: :rateable, to: :closed; end
  end

  def paid_code!
    pay!
    # printout!
    # deliver!
    # receive!
    if update_attributes!({paid_code_at: Time.now, paid_code: get_paid_code})
      # log (open "#{Settings.host}/api#{paid_code_url}")
      return paid_code
    end
  end

  def paid_code_url
    if request_by_code && aasm.current_state == :printable
      "/papers/#{self.id}/download?token=#{self.paid_code}"
    end
  end

  def get_paid_code
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless self.class.exists?(paid_code: token)
    end
  end


  def pay_dollar!
    # begin
    Udollar.after_paper_created!(self)
    # rescue
    # end
  end

  def after_state
    super
    case state
    when :unpaid
      title = "請求正本列印請求",
      body = "我們已收到您的正本輸出請求。請到「申請追蹤」之「待付款」進行付款。"
    when :printable
      if !request_by_code
        title = "列印排程中"
        body = "根據印刷中心回報，大約 #{[1, 2, 3].sample} 個工作天。"
      end
    when :deliverable
      if !request_by_code
        title = "目前輸出完成，案件正轉交服務中心"
        body = "服務中心簽收後，會再通知您去領取"
      end
    when :receivable
      if !request_by_code
        title = "已可領取"
        body = "證書已送到服務中心簽收，您可持學生證至服務中心領取。案號為: 101#{(10...20).to_a.sample}。"
      end
    when :rateable
      title = "您已領取 #{cert.title}"
      body = "感謝您使用 iCert 證書管理平台。請對我們的服務給予評價。"
    when :closed
      title = "謝謝您的評價"
      body = "歡迎下次再度使用 iCert 證書管理平台。"
    else
      title = state
      body = "本狀態 #{state} 的推播待定義"
    end

    if title
      User.first.push!({title: title, body: body}, {state: state})
    end
  end

  def pri_button
    super
    case state
    when :unpaid
      if request_by_code
        "付款[建立輸出條碼]"
      else
        "付款"
      end
    when :printable
      if request_by_code
        "顯示輸出條碼"
      end
    when :deliverable
    when :receivable
      "服務中心取件"
    when :rateable
      "評價"
    when :closed
    end
  end

  def sub_button
    super
    super
    case state
    when :unpaid
    when :printable
      if !request_by_code
        "輸出/蓋鋼印"
      end
    when :deliverable
      "轉交服務中心"
    when :receivable
    when :rateable
    when :closed
    end
  end

  def next_event
    events = Paper.aasm.events.map{|s| s.name}
    states = Paper.aasm.states.map{|s| s.name}
    index = states.index(aasm.current_state)
    event = events[index]
    if (event == :pay) && self.request_by_code == true
      return "pay_by_code"
    else
      return event
    end
  end

  def title
    cert.title
  end

  def after_all_events
    log_event_at!
  end
end

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
