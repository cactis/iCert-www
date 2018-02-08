require 'test_helper'

class ThemeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: themes
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
#  index_themes_on_user_id  (user_id)
#
