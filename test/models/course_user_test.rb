require 'test_helper'

class CourseUserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
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
