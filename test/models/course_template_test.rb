require 'test_helper'

class CourseTemplateTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: course_templates
#
#  id             :integer          not null, primary key
#  course_id      :integer
#  template_id    :integer
#  expired_date   :datetime
#  settings       :text(16777215)
#  include_scores :boolean
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
# Indexes
#
#  index_course_templates_on_course_id                  (course_id)
#  index_course_templates_on_course_id_and_template_id  (course_id,template_id) UNIQUE
#  index_course_templates_on_template_id                (template_id)
#
