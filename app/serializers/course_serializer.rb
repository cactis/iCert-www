class CourseSerializer < BaseSerializer
  attributes :title, :has_cert, :start_date, :end_date, :hours, :percentage
end
