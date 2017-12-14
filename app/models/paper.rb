class Paper < ApplicationRecord

  belongs_to :cert
  has_many :udollars, foreign_key: "payable_id", foreign_type: "payable_type", dependent: :destroy

  typed_store :settings do |s|
    s.datetime :pay_at
    s.datetime :printout_at
    s.datetime :deliver_at
    s.datetime :receive_at
    s.datetime :rate_at
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
    event :receive do; transitions from: :receivable, to: :rateable; end
    event :rate do; transitions from: :rateable, to: :closed; end
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
      title = "列印排程中"
      body = "根據印刷中心回報，大約 #{[1, 2, 3].sample} 個工作天。"
    when :deliverable
      title = "目前輸出完成，案件正轉交服務中心"
      body = "服務中心簽收後，會再通知您去領取"
    when :receivable
      title = "已可領取"
      body = "證書已送到服務中心簽收，您可持學生證至服務中心領取。案號為: 101#{(10...20).to_a.sample}。"
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
    User.first.push!({title: title, body: body}, {state: state})
  end

  def pri_button
    super
    case state
    when :unpaid
      "付款"
    when :printable
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
      "輸出/蓋鋼印"
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
    events[index]
  end

  def title
    cert.title
  end

  def after_all_events
    log_event_at!
  end
end
