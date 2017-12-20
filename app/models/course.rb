class Course < ApplicationRecord

  has_many :certs, dependent: :destroy

  def self.seed_params(index = 0)
    date = Time.now + [-10, -20, -3, 5, 10, 30].sample
    hours = [20, 40, 60, 80, 100, 120, 200, 300].sample
    {
      title: Faker::Educator.course,
      has_cert: [true, true, false].sample,
      hours: hours,
      percentage: (8...9).to_a.map{|i| i * 10}.sample,
      start_date: date,
      end_date: date + 10
    }
  end

  after_create do |record|
    body = "本課程沒有結業證書。"
    if has_cert
      cert = record.certs.create! Cert.seed_params
      body = "本課程結業時會有一張結業證書哦。"
    end
    User.first.push!({title: "歡迎參加本課程研習", body: body})
  end

  after_save do |record|
    if record.percentage == 100
      record.certs_publish!
    end
  end

  def certs_publish!
    log certs, 'certs'
    if certs.present?
      certs.each do |cert|
        cert.ready_to_confirm!
      end
    else
      User.first.push!({title: "課程已結束囉", body: "本課程沒有結業證書。感謝您認真參與本課程研習。"})
    end
  end

  def cert
    certs.first
  end

  def plus!
    if percentage < 100
      update(percentage: percentage + 10)
    else
      certs_publish!
    end
  end

  def finish!
    update_attribute :percentage, 100
  end

end
