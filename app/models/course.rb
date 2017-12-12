class Course < ApplicationRecord

  has_many :certs, dependent: :destroy

  def self.seed_params(index = 0)
    date = Time.now + [-10, -20, -3, 5, 10, 30].sample
    hours = [20, 40, 60, 80, 100, 120, 200, 300].sample
    {
      title: Faker::Educator.course,
      has_cert: [true, false].sample,
      hours: hours,
      percentage: (10..100).to_a.sample,
      start_date: date,
      end_date: date + 10
    }
  end

  after_create do |record|
    if has_cert
      cert = record.certs.create! Cert.seed_params
      log cert, 'cert'
      log cert.course, 'course'
    end
  end

  after_save do |record|
    if record.percentage == 100
      record.certs_publish!
    end
  end

  def certs_publish!
    certs.each do |cert|
      cert.publish!
    end
  end

  def finish!
    update_attribute :percentage, 100
  end

end
