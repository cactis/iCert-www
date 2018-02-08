class CourseUser < ApplicationRecord
  belongs_to :user
  belongs_to :course
  has_many :certs, dependent: :restrict_with_exception
  has_many :course_user_subjects

  def self.seed_params
    {
      course: Course.first,
      user: User.first
    }
  end

  after_create do |record|
    body = "本課程沒有結業證書。"
    course = record.course
    # if record.course.has_cert
      cert = record.certs.new
      cert.course_template = course.course_templates.first
      cert.save
      body = "本課程結業時會有一張結業證書哦。"
      # record.course.finish!
      # cert.confirm!
    # end
  end


end

# == Schema Information
#
# Table name: course_users
#
#  id         :integer          not null, primary key
#  course_id  :integer          not null
#  user_id    :integer          not null
#  settings   :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_course_users_on_course_id              (course_id)
#  index_course_users_on_course_id_and_user_id  (course_id,user_id) UNIQUE
#  index_course_users_on_user_id                (user_id)
#
