class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # default_scope { order("id desc") }
  # aasm :logger => Rails.logger do; end
  def pri_button; end
  def sub_button; end

  def next_event
    respond_to?("aasm") ? state = aasm.current_state : nil
  end

  def log_event_at!
    update_attribute "#{aasm.current_event.to_s.gsub('!', '')}_at", Time.now.utc
  end

  def after_state
    state = aasm.current_state
  end

  def self.seed
    new seed_params
  end

  def self.seed!#(index = 0)
    create! seed_params#(index)
  end

  def state
    respond_to?("aasm") ? aasm.current_state : nil
  end

  def status
  end


  def self.development?
    ["development", "stage"].include? Rails.env
  end

  def development?
    self.class.development?
  end

  def self.log(*args)
    _log name, args
  end

  def log(*args)
    return unless development?
    title ||= ""
    Rails.logger.ap args
  end

  def self._log(klass, *args)
    return unless development?
    title ||= ""
    Rails.logger.ap args
  end

end
