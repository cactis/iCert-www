class CourseSerializer < BaseSerializer
  attributes :title, :has_cert, :start_date, :end_date, :hours, :percentage, :percentage_desc

  has_many :certs

  def percentage_desc
    "課程進度: #{object.percentage}%" + (object.percentage == 100 ? " [已結業]" : "")
  end
end
