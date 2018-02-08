class CourseUserSubjectSerializer < ActiveModel::Serializer
  attributes :id
end

# == Schema Information
#
# Table name: course_user_subjects
#
#  id                :integer          not null, primary key
#  course_user_id    :integer          not null
#  course_subject_id :integer          not null
#  score             :integer
#  settings          :text(65535)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
# Indexes
#
#  index_course_user_subjects_on_course_subject_id  (course_subject_id)
#  index_course_user_subjects_on_course_user_id     (course_user_id)
#
