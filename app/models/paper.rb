class Paper < ApplicationRecord

  belongs_to :cert

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
    event :pay do; transitions from: :unpaid, to: :printable; end
    event :printout do; transitions from: :printable, to: :deliverable; end
    event :deliver do; transitions from: :deliverable, to: :receivable; end
    event :receive do; transitions from: :receivable, to: :rateable; end
    event :rate do; transitions from: :rateable, to: :closed; end
  end

  def after_state
    super
    case state
    when :unpaid
      User.first.push!({title: "請求正本列印請求", body: "我們已收到您的正本輸出請求。"}, {state: state})
    else
      User.first.push!({title: state, body: "本狀態 #{state} 的推播待定義"}, {state: state})
    end
  end

  def pri_button
    super
    case state
    when :unpaid
      "學生付款"
    when :printable
      "學校輸出/蓋鋼印"
    when :deliverable
      "學校包裝寄送"
    when :receivable
      "學生收件去"
    when :rateable
      "學生評價去"
    when :closed
    end
  end

  def next_event
    events = Paper.aasm.events.map{|s| s.name}
    states = Paper.aasm.states.map{|s| s.name}
    index = states.index(aasm.current_state)
    events[index]
  end

  def after_all_events
    log_event_at!
  end
end
