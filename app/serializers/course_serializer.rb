# == Schema Information
#
# Table name: courses
#
#  id         :integer          not null, primary key
#  title      :string(255)
#  has_cert   :boolean
#  hours      :integer
#  percentage :integer
#  start_date :datetime
#  end_date   :datetime
#  aasm_state :string(255)
#  settings   :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CourseSerializer < BaseSerializer
  attributes :title, :has_cert, :start_date, :end_date, :hours, :percentage, :percentage_desc

  has_many :certs

  def percentage_desc
    "課程進度: #{object.percentage}%" + (object.percentage == 100 ? " [已結業]" : "")
  end
end
