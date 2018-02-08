class CertNewSerializer < ActiveModel::Serializer
  # attributes

  belongs_to :course_user, serializer: CourseUserSerializer

  class CourseUserSerializer < ActiveModel::Serializer
    belongs_to :course
    belongs_to :user
  end

  # class CourseSerialiizer < ActiveModel::Serializer
  # end

end