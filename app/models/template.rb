class Template < ApplicationRecord
  has_many :course_templates, dependent: :destroy
  has_many :certs, through: :course_templates

  def self.seed_params
    {
      title: "#{Faker::Lorem.word} 證書樣式",
      data: "SVGDATA"
    }
  end

  after_update do |record|
    certs.each do |cert|
      cert.generate_photo!
    end
  end

end

# == Schema Information
#
# Table name: templates
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  title      :string(255)
#  data       :text(65535)
#  settings   :text(65535)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_templates_on_user_id  (user_id)
#
