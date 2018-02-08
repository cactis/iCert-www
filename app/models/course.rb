class Course < ApplicationRecord

  # has_many :certs, dependent: :destroy
  has_many :course_users, dependent: :destroy
  has_many :certs, through: :course_users
  has_many :course_templates, dependent: :destroy
  has_many :course_subjects, dependent: :destroy

  belongs_to :cert_detail

  def self.seed_params(index = 0)
    date = Time.now + [-10, -20, -3, 5, 10, 30].sample
    hours = [20, 40, 60, 80, 100, 120, 200, 300].sample
    {
      title: Faker::Educator.course,
      has_cert: true, #[true, true, false].sample,
      hours: hours,
      percentage: (8...9).to_a.map{|i| i * 10}.sample,
      start_date: date,
      end_date: date + 10
    }
  end

  typed_store :settings do |t|
    t.string :CLAS_ID
    t.string :STUD_ID
    t.integer :STUD_NO
    t.string :STUD_NAME
    t.string :ITEM_NO
    t.string :ITEM_NAME
    t.string :CLAS_NAME
    t.integer :CLAS_SERIAL
    t.decimal :ITEM_POINT
    t.string :MASTER_NO
    t.string :CLS_POINTS
    t.string :ENG_NAME
    t.string :STUD_ENGNAME
    t.datetime :BIRTH
    t.string :SEX
    t.string :CLAS_ENGNAME
    t.integer :BUDG_MONTH
    t.integer :BUDG_YEAR
    t.datetime :BUDG_ACTUOPENDATE
    t.string :CLAS_WORD
    t.datetime :CLAS_ENDDATE
    t.integer :SNO
    t.integer :ABS_HOUR
    t.decimal :BUDG_TOTALHOURS
    t.decimal :BUDG_HOURCOUNT
    t.integer :GRP_SNO
    t.string :scls_id
    t.string :MEMO
    t.string :REQUIRED
    t.string :TERM
    t.datetime :OPEN_DATE
    t.datetime :END_DATE
    t.string :OUT_SNO
    t.string :GRAD_SIGN
  end

  after_create do |record|

    course_template = record.course_templates.new
    course_template.template = Template.first
    course_template.save

    course_user = record.course_users.new
    course_user.user = User.first
    course_user.save
    # User.first.push!({title: "歡迎參加本課程研習", body: body})
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

# == Schema Information
#
# Table name: courses
#
#  id             :integer          not null, primary key
#  cert_detail_id :integer
#  title          :string(255)
#  has_cert       :boolean
#  hours          :integer
#  percentage     :integer
#  start_date     :datetime
#  end_date       :datetime
#  aasm_state     :string(255)
#  settings       :text(65535)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_courses_on_cert_detail_id  (cert_detail_id)
#
