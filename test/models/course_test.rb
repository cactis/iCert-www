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

require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
