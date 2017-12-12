class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # def self.all
  #   (1...20).map{|index| seed_params index }
  # end

  def self.seed!(index = 0)
    create! seed_params(index)
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
