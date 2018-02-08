class SubjectSerializer < ActiveModel::Serializer
  attributes :id
end

# == Schema Information
#
# Table name: subjects
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)
#  settings   :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_subjects_on_user_id  (user_id)
#
