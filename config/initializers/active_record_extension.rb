
# -*- encoding : utf-8 -*-
class ActiveRecord::Base
  #  site_id = current_site
  #  default_scope :conditions => ["site_id = ?", eval("#{ActiveRecord::Base::get_current_site}")]

  # WillPaginate::ViewHelpers.pagination_options[:previous_label] = '«'
  # WillPaginate::ViewHelpers.pagination_options[:next_label] = "»"

  # cattr_reader :per_page
  # @@per_page = 10

  def self.update_or_create_by(args, attributes)
    self.find_or_create_by(args)
    self.update(attributes)
  end


  def get_unique_token
    loop do
      token = SecureRandom.base64.tr('+/=', 'Qrt')
      break token unless self.class.exists?(token: token)
    end
  end

  def renew_token!
    update_attribute("token", get_unique_token)
    return token
  end

  def validate_token
    return token || renew_token!
  end

  before_create do |record|
    if record.has_attribute?(:token) && record.token == nil
      record.token = record.get_unique_token
    end
    if record.has_attribute?(:user_id) && record.user_id == nil
      record.user_id = User.current.id if User.current
    end
  end

  def save_without_timestamping
    class << self
      def record_timestamps; false; end
    end
    save
    class << self
      def record_timestamps; super ; end
    end
  end

  def is_owner?
    if User.current
      user_id == User.current.id
    else
      false
    end
  end

  def self.development?
    ["development", "stage"].include? Rails.env
  end

  def development?
    self.class.development?
  end

  def self.log(*args)
    # return unless development?
    # title ||= ""
    # # Rails.logger.ap '-' * 20 + calling_method + '-' * 20
    # Rails.logger.ap ">>> #{calling_method} "
    # Rails.logger.ap args
    # # Rails.logger.ap '-' * 100
    # Rails.logger.ap "<<< #{calling_method}" + " -- #{self.class.to_s}"
    _log name, args
  end

  def log(*args)
    return unless development?
    title ||= ""
    Rails.logger.ap ">>> #{calling_method} "
    Rails.logger.ap args
    self.class.logline calling_method, User.current_name, self.class.to_s, __FILE__, __LINE__
  end

  def self._log(klass, *args)
    return unless development?
    title ||= ""
    Rails.logger.ap ">>> #{calling_method} "
    Rails.logger.ap args
    logline calling_method, User.current_name, klass, __FILE__, __LINE__
  end

  def self.logline(calling_method, who, klass, file, line)
    Rails.logger.ap "<<< #{calling_method}" + " who: #{who} -- #{klass}"
  end

end
