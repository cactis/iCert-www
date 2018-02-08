class CertDemoSerializer < ActiveModel::Serializer
  attributes :title

  belongs_to :course_user
  belongs_to :course_template

  class CourseUserSerializer < ActiveModel::Serializer
    attributes :course, :user
    belongs_to :course
    belongs_to :user
  end

  class CourseTemplateSerializer < ActiveModel::Serializer
    attributes :course, :template_id
    # belongs_to :course
    # belongs_to :template
  end

end