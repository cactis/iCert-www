require 'test_helper'

class CourseSubjectTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: course_subjects
#
#  id         :integer          not null, primary key
#  course_id  :integer          not null
#  subject_id :integer          not null
#  credits    :integer
#  settings   :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_course_subjects_on_course_id   (course_id)
#  index_course_subjects_on_subject_id  (subject_id)
#
